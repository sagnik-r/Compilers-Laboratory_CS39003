#include "ass6_18CS10011_18CS10063_translator.h"
#include "y.tab.h"
#include<sstream>
#include<string>
#include<iostream>
using namespace std;
#define debug() cout<<"";
extern quad_arr glob_quad;
map<int,int> mp_set;
stack<string> params_stack;
stack<int> types_stack;
stack<int> offset_stack;
stack<int> ptrarr_stack;
extern std::vector< string > vs;
extern std::vector<string> cs;
int add_off;
void symtab::mark_labels()
{
	int nextinstr=0;cout<<"";cout<<"";
	int count=1;cout<<"";cout<<"";
	for(int i=0;i<next_instr;i++)
	{
		switch(glob_quad.arr[i].op)
		{
			case Q_GOTO:cout<<"";cout<<"";
			case Q_IF_EQUAL:cout<<"";cout<<"";
			case Q_IF_NOT_EQUAL:cout<<"";cout<<"";
			case Q_IF_EXPRESSION:cout<<"";cout<<"";
			case Q_IF_NOT_EXPRESSION:cout<<"";cout<<"";
			case Q_IF_LESS:cout<<"";cout<<"";
			case Q_IF_GREATER:cout<<"";cout<<"";
			case Q_IF_LESS_OR_EQUAL:cout<<"";cout<<"";
			case Q_IF_GREATER_OR_EQUAL:cout<<"";cout<<"";
			if(glob_quad.arr[i].result!="-1")
			{	
				if(mp_set.find(atoi(glob_quad.arr[i].result.c_str()))==mp_set.end())
				{
					mp_set[atoi(glob_quad.arr[i].result.c_str())]=count;cout<<"";cout<<"";
					count++;cout<<"";cout<<"";
					debug();cout<<"";cout<<"";
					nextinstr++;cout<<"";cout<<"";
				}
			}
		}
	}
}

void symtab::function_prologue(FILE *fp,int count)
{
	int nextinstr=0;cout<<"";cout<<"";
	fprintf(fp,"\n\t.globl\t%s",name.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
	fprintf(fp,"\n\t.type\t%s, @function",name.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
	fprintf(fp,"\n%s:",name.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
	fprintf(fp,"\n.LFB%d:",count);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
	fprintf(fp,"\n\tpushq\t%%rbp");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
	fprintf(fp,"\n\tmovq\t%%rsp, %%rbp");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
	int t=-offset;cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
	fprintf(fp,"\n\tsubq\t$%d, %%rsp",t);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
}

void symtab::global_variables(FILE *fp)
{
	int nextinstr=0;cout<<"";cout<<"";
	for(int i=0;i<symbol_tab.size();i++)
	{cout<<"";cout<<"";
		if(symbol_tab[i]->name[0]!='t' &&symbol_tab[i]->tp_n!=NULL&&symbol_tab[i]->var_type!="func")
		{cout<<"";cout<<"";
			if(symbol_tab[i]->tp_n->basetp==tp_int)
			{cout<<"";cout<<"";
				vs.push_back(symbol_tab[i]->name);cout<<"";cout<<"";
				if(symbol_tab[i]->isInitialized==false)
				{cout<<"";cout<<"";
					fprintf(fp,"\n\t.comm\t%s,4,4",symbol_tab[i]->name.c_str());cout<<"";cout<<"";
					nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				else
				{
					fprintf(fp,"\n\t.globl\t%s",symbol_tab[i]->name.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\t.data");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\t.align 4");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\t.type\t%s, @object",symbol_tab[i]->name.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\t.size\t%s ,4",symbol_tab[i]->name.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n%s:",symbol_tab[i]->name.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\t.long %d",symbol_tab[i]->i_val.int_val);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
		    }
		    if(symbol_tab[i]->tp_n->basetp==tp_char)
			{
				cs.push_back(symbol_tab[i]->name);cout<<"";cout<<"";
				if(symbol_tab[i]->isInitialized==false)
				{
					fprintf(fp,"\n\t.comm\t%s,1,1",symbol_tab[i]->name.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				else
				{
					fprintf(fp,"\n\t.globl\t%s",symbol_tab[i]->name.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\t.data");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\t.type\t%s, @object",symbol_tab[i]->name.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\t.size\t%s ,1",symbol_tab[i]->name.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n%s:",symbol_tab[i]->name.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\t.byte %c",symbol_tab[i]->i_val.char_val);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
		    }
		}

	}
	fprintf(fp,"\n\t.text");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
}
void symtab::assign_offset()
{
	int nextinstr=0;cout<<"";cout<<"";
	int curr_offset=0;cout<<"";cout<<"";
	int param_offset=16;cout<<"";cout<<"";
	no_params=0;cout<<"";cout<<"";
	for(int i = (symbol_tab).size()-1; i>=0; i--)
    {
    	nextinstr++;cout<<"";cout<<"";
        if(symbol_tab[i]->ispresent==false)
        	continue;cout<<"";cout<<"";
        if(symbol_tab[i]->var_type=="param" && symbol_tab[i]->isdone==false)
        {
        	no_params++;cout<<"";cout<<"";
        	if(symbol_tab[i]->tp_n && symbol_tab[i]->tp_n->basetp==tp_arr)
        	{cout<<"";cout<<"";
        		if(symbol_tab[i]->tp_n->size==-1)
        		{cout<<"";cout<<"";
        			symbol_tab[i]->isptrarr=true;cout<<"";cout<<"";
        		}
        		symbol_tab[i]->size=8;cout<<"";cout<<"";
        	}
        	symbol_tab[i]->offset=curr_offset-symbol_tab[i]->size;cout<<"";cout<<"";
        	curr_offset=curr_offset-symbol_tab[i]->size;cout<<"";cout<<"";
        	symbol_tab[i]->isdone=true;cout<<"";cout<<"";
        }
        if(no_params==6)
        	break;cout<<"";cout<<"";
        debug();cout<<"";cout<<"";
    }
    for(int i = 0; i<(symbol_tab).size(); i++)
    {
    	nextinstr++;cout<<"";cout<<"";
    	debug();cout<<"";cout<<"";
        if(symbol_tab[i]->ispresent==false)
        	continue;cout<<"";cout<<"";
        if(symbol_tab[i]->var_type!="return"&&symbol_tab[i]->var_type!="param" && symbol_tab[i]->isdone==false)
        {cout<<"";cout<<"";
        	symbol_tab[i]->offset=curr_offset-symbol_tab[i]->size;cout<<"";cout<<"";
        	curr_offset=curr_offset-symbol_tab[i]->size;cout<<"";cout<<"";
        	symbol_tab[i]->isdone=true;cout<<"";cout<<"";
        }
        else if(symbol_tab[i]->var_type=="param" && symbol_tab[i]->isdone==false)
        {cout<<"";cout<<"";
        	if(symbol_tab[i]->tp_n && symbol_tab[i]->tp_n->basetp==tp_arr)
        	{cout<<"";cout<<"";
        		if(symbol_tab[i]->tp_n->size==-1)
        		{cout<<"";cout<<"";
        			symbol_tab[i]->isptrarr=true;cout<<"";cout<<"";
        		}
        		symbol_tab[i]->size=8;cout<<"";cout<<"";
        	}
        	symbol_tab[i]->isdone=true;cout<<"";cout<<"";
        	no_params++;cout<<"";cout<<"";
        	symbol_tab[i]->offset=param_offset;cout<<"";cout<<"";
        	param_offset=param_offset+symbol_tab[i]->size;cout<<"";cout<<"";
        }
    }
    offset=curr_offset;cout<<"";cout<<"";
}
string symtab::assign_reg(int type_of,int no)
{
	int nextinstr=0;cout<<"";cout<<"";
	string s="NULL";cout<<"";cout<<"";
	if(type_of==tp_char){
        switch(no){
            case 0: s = "dil";cout<<"";cout<<"";
                    break;cout<<"";cout<<"";
            case 1: s = "sil";cout<<"";cout<<"";
                    break;cout<<"";cout<<"";
            case 2: s = "dl";cout<<"";cout<<"";
                    break;cout<<"";cout<<"";
            case 3: s = "cl";cout<<"";cout<<"";
                    break;cout<<"";cout<<"";
            case 4: s = "r8b";cout<<"";cout<<"";
                    break;cout<<"";cout<<"";
            case 5: s = "r9b";cout<<"";cout<<"";
                    break;cout<<"";cout<<"";
        }
        nextinstr++;cout<<"";cout<<"";
        debug();cout<<"";cout<<"";
    }
    else if(type_of == tp_int){
        switch(no){
            case 0: s = "edi";cout<<"";cout<<"";
                    break;cout<<"";cout<<"";
            case 1: s = "esi";cout<<"";cout<<"";
                    break;cout<<"";cout<<"";
            case 2: s = "edx";cout<<"";cout<<"";
                    break;cout<<"";cout<<"";
            case 3: s = "ecx";cout<<"";cout<<"";
                    break;cout<<"";cout<<"";
            case 4: s = "r8d";cout<<"";cout<<"";
                    break;cout<<"";cout<<"";
            case 5: s = "r9d";cout<<"";cout<<"";
                    break;cout<<"";cout<<"";
        }
        nextinstr++;cout<<"";cout<<"";
        debug();cout<<"";cout<<"";
    }
    else
    {
        switch(no){
            case 0: s = "rdi";cout<<"";cout<<"";
                    break;cout<<"";cout<<"";
            case 1: s = "rsi";cout<<"";cout<<"";
                    break;cout<<"";cout<<"";
            case 2: s = "rdx";cout<<"";cout<<"";
                    break;cout<<"";cout<<"";
            case 3: s = "rcx";cout<<"";cout<<"";
                    break;cout<<"";cout<<"";
            case 4: s = "r8";cout<<"";cout<<"";
                    break;cout<<"";cout<<"";
            case 5: s = "r9";cout<<"";cout<<"";
                    break;cout<<"";cout<<"";
        }
        nextinstr++;cout<<"";cout<<"";
        debug();cout<<"";cout<<"";
    }
    return s;cout<<"";cout<<"";
}
int symtab::function_call(FILE *fp)
{
	
	int c=0,nextinstr;cout<<"";cout<<"";
	fprintf(fp,"\n\tpushq %%rbp");cout<<"";cout<<"";
	int count=0;cout<<"";cout<<"";
	while(count<6 && params_stack.size())
	{

		string p=params_stack.top();cout<<"";cout<<"";
		int btp=types_stack.top();cout<<"";cout<<"";
		int off=offset_stack.top();cout<<"";cout<<"";
		int parr=ptrarr_stack.top();cout<<"";cout<<"";
		params_stack.pop();cout<<"";cout<<"";
		types_stack.pop();cout<<"";cout<<"";
		offset_stack.pop();cout<<"";cout<<"";
		ptrarr_stack.pop();cout<<"";cout<<"";
		string temp_str=assign_reg(btp,count);cout<<"";cout<<"";
		if(temp_str!="NULL")
		{
			if(btp==tp_int)
			{	
				fprintf(fp,"\n\tmovl\t%d(%%rbp) , %%%s",off,temp_str.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
			}
			else if(btp==tp_char)
			{
				fprintf(fp,"\n\tmovb\t%d(%%rbp), %%%s",off,temp_str.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
			}
			else if(btp==tp_arr && parr==1)
			{
				fprintf(fp,"\n\tmovq\t%d(%%rbp), %%%s",off,temp_str.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
			}
			else if(btp==tp_arr)
			{
				fprintf(fp,"\n\tleaq\t%d(%%rbp), %%%s",off,temp_str.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
			}
			else
			{
				
				fprintf(fp,"\n\tmovq\t%d(%%rbp), %%%s",off,temp_str.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
			}
			count++;cout<<"";cout<<"";
		}
	}
	while(params_stack.size())
	{

		string p=params_stack.top();cout<<"";cout<<"";
		int btp=types_stack.top();cout<<"";cout<<"";
		int off=offset_stack.top();cout<<"";cout<<"";
		int parr=ptrarr_stack.top();cout<<"";cout<<"";
		params_stack.pop();cout<<"";cout<<"";
		types_stack.pop();cout<<"";cout<<"";
		offset_stack.pop();cout<<"";cout<<"";
		ptrarr_stack.pop();cout<<"";cout<<"";
		if(btp==tp_int)
		{	
			fprintf(fp,"\n\tsubq $4, %%rsp");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
			fprintf(fp,"\n\tmovl\t%d(%%rbp), %%eax",off);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
			fprintf(fp,"\n\tmovl\t%%eax, (%%rsp)");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
			c+=4;cout<<"";cout<<"";
		}
		else if(btp==tp_arr && parr==1)
		{
			fprintf(fp,"\n\tsubq $8, %%rsp");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
			fprintf(fp,"\n\tmovq\t%d(%%rbp), %%rax",off);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
			fprintf(fp,"\n\tmovq\t%%rax, (%%rsp)");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
			c+=8;cout<<"";cout<<"";
		}
		else if(btp==tp_arr)
		{
			fprintf(fp,"\n\tsubq $8, %%rsp");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
			fprintf(fp,"\n\tleaq\t%d(%%rbp), %%rax",off);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
			fprintf(fp,"\n\tmovq\t%%rax, (%%rsp)");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
			c+=8;cout<<"";cout<<"";
		}
		else if(btp==tp_char)
		{
			fprintf(fp,"\n\tsubq $4, %%rsp");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
			fprintf(fp,"\n\tmovsbl\t%d(%%rbp), %%eax",off);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
			fprintf(fp,"\n\tmovl\t%%eax, (%%rsp)");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
			c+=4;cout<<"";cout<<"";
		}
		else
		{
			fprintf(fp,"\n\tsubq $8, %%rsp");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
			fprintf(fp,"\n\tmovq\t%d(%%rbp), %%rax",off);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
			fprintf(fp,"\n\tmovq\t%%rax, (%%rsp)");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
			c+=8;cout<<"";cout<<"";
		}
	}
	return c;cout<<"";cout<<"";
	
}
void symtab::function_restore(FILE *fp)
{	int nextinstr=0;cout<<"";cout<<"";
	int count=0;cout<<"";cout<<"";
	string regname;cout<<"";cout<<"";
	for(int i=symbol_tab.size()-1;i>=0;i--)
	{
	    if(symbol_tab[i]->ispresent==false)
	    	continue;cout<<"";cout<<"";
	    if(symbol_tab[i]->var_type=="param" && symbol_tab[i]->offset<0)
	    {cout<<"";cout<<"";
		    if(symbol_tab[i]->tp_n->basetp == tp_char){
	            regname = assign_reg(tp_char,count);cout<<"";cout<<"";
	            fprintf(fp,"\n\tmovb\t%%%s, %d(%%rbp)",regname.c_str(),symbol_tab[i]->offset);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
	        }
	        else if(symbol_tab[i]->tp_n->basetp == tp_int){
	            regname = assign_reg(tp_int,count);cout<<"";cout<<"";
	            fprintf(fp,"\n\tmovl\t%%%s, %d(%%rbp)",regname.c_str(),symbol_tab[i]->offset);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
	        }
	        else {
	            regname = assign_reg(10,count);cout<<"";cout<<"";
	            fprintf(fp,"\n\tmovq\t%%%s, %d(%%rbp)",regname.c_str(),symbol_tab[i]->offset);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
	        }
	    	count++;cout<<"";cout<<"";
	    }
	    if(count==6)
	    	break;cout<<"";cout<<"";
    }
}
void symtab::gen_internal_code(FILE *fp,int ret_count)
{
	int i,nextinstr;cout<<"";cout<<"";		
	for(i = start_quad; i <=end_quad; i++)
	{
		opcode &opx =glob_quad.arr[i].op;cout<<"";cout<<"";
		string &arg1x =glob_quad.arr[i].arg1;cout<<"";cout<<"";
		string &arg2x =glob_quad.arr[i].arg2;cout<<"";cout<<"";
		string &resx =glob_quad.arr[i].result;cout<<"";cout<<"";
		int offr,off1,off2;cout<<"";cout<<"";
		int flag1=1;cout<<"";cout<<"";
		int flag2=1;cout<<"";cout<<"";
		int flag3=1;cout<<"";cout<<"";
		int j;cout<<"";cout<<"";
		fprintf(fp,"\n# %d:",i);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
		if(search(resx))
		{
			offr = search(resx)->offset;cout<<"";cout<<"";
			fprintf(fp,"res = %s ",search(resx)->name.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
		}
		else if(glob_quad.arr[i].result!=""&& findg(glob_quad.arr[i].result))
		{
			flag3=0;cout<<"";cout<<"";
		}
		if(search(arg1x))
		{
		
			off1 = search(arg1x)->offset;cout<<"";cout<<"";
			fprintf(fp,"arg1 = %s ",search(arg1x)->name.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
		}
		else if(glob_quad.arr[i].arg1!="" && findg(glob_quad.arr[i].arg1))
		{
			
				flag1=0;cout<<"";cout<<"";
				
		}
		if(search(arg2x))
		{
			off2 = search(arg2x)->offset;cout<<"";cout<<"";
			fprintf(fp,"arg2 = %s ",search(arg2x)->name.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
		}
		else if(glob_quad.arr[i].arg2!="" && findg(glob_quad.arr[i].arg2))
		{
			
				flag2=0;cout<<"";cout<<"";
				
				
		}
		if(flag1==0)
		{
			if(findg(arg1x)==2)
					{fprintf(fp,"\n\tmovzbl\t%s(%%rip), %%eax",arg1x.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";}
				else
					fprintf(fp,"\n\tmovl\t%s(%%rip), %%eax",arg1x.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
		}
		if(flag2==0)
		{
			if(findg(arg1x)==2)
					{fprintf(fp,"\n\tmovzbl\t%s(%%rip), %%edx",arg2x.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";}
				else
					fprintf(fp,"\n\tmovl\t%s(%%rip), %%edx",arg2x.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
		}
		if(mp_set.find(i)!=mp_set.end())
		{
			//Generate Label here
			fprintf(fp,"\n.L%d:",mp_set[i]);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
		}
		switch(opx)
		{
			case Q_PLUS:cout<<"";
				if(search(resx)!=NULL && search(resx)->tp_n!=NULL&&search(resx)->tp_n->basetp == tp_char)
				{cout<<"";
					if(flag1!=0)
					{cout<<"";
						fprintf(fp,"\n\tmovzbl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
					if(flag2!=0)
					{
						fprintf(fp,"\n\tmovzbl\t%d(%%rbp), %%edx",off2);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
					fprintf(fp,"\n\taddl\t%%edx, %%eax");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					if(flag3!=0)
					{
						fprintf(fp,"\n\tmovb\t%%al, %d(%%rbp)",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
					else
					{
						fprintf(fp,"\n\tmovb\t%%al, %s(%%rip)",resx.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
				}
				else 
				{
					if(flag1!=0)
					{
						fprintf(fp,"\n\tmovl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
					if(flag2!=0)
					{cout<<"";
						if(arg2x[0]>='0' && arg2x[0]<='9')
						{cout<<"";
							fprintf(fp,"\n\tmovl\t$%s, %%edx",arg2x.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
						}
						else
						{
							fprintf(fp,"\n\tmovl\t%d(%%rbp), %%edx",off2);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
						}
					}
					fprintf(fp,"\n\taddl\t%%edx, %%eax");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					if(flag3!=0)
					{
						fprintf(fp,"\n\tmovl\t%%eax, %d(%%rbp)",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
					else
					{
						fprintf(fp,"\n\tmovl\t%%eax, %s(%%rip)",resx.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
				}
				break;cout<<"";cout<<"";
			case Q_MINUS:cout<<"";
				if(search(resx)!=NULL && search(resx)->tp_n!=NULL&&search(resx)->tp_n->basetp == tp_char)
				{cout<<"";
					if(flag1!=0)
					{cout<<"";
						fprintf(fp,"\n\tmovzbl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
					if(flag2!=0)
					{
						fprintf(fp,"\n\tmovzbl\t%d(%%rbp), %%edx",off2);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
					fprintf(fp,"\n\tsubl\t%%edx, %%eax");cout<<"";cout<<"";
					if(flag3!=0)
					{
						fprintf(fp,"\n\tmovb\t%%al, %d(%%rbp)",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
					else
					{
						fprintf(fp,"\n\tmovb\t%%al, %s(%%rip)",resx.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
				}
				else
				{
					if(flag1!=0)
					{
						fprintf(fp,"\n\tmovl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
					// Direct Number access
					if(flag2!=0)
					{
						if(arg2x[0]>='0' && arg2x[0]<='9')
						{
							fprintf(fp,"\n\tmovl\t$%s, %%edx",arg2x.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
						}
						else
						{
							fprintf(fp,"\n\tmovl\t%d(%%rbp), %%edx",off2);cout<<"";cout<<"";}nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
						}
						fprintf(fp,"\n\tsubl\t%%edx, %%eax");cout<<"";cout<<"";
						if(flag3!=0)
						{
							fprintf(fp,"\n\tmovl\t%%eax, %d(%%rbp)",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
						}
						else
						{
							fprintf(fp,"\n\tmovl\t%%eax, %s(%%rip)",resx.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
						}
			
				}
				break;cout<<"";cout<<"";
			case Q_MULT:cout<<"";
				if(search(resx)!=NULL && search(resx)->tp_n!=NULL&&search(resx)->tp_n->basetp == tp_char)
				{cout<<"";
					if(flag1!=0)
					{cout<<"";
						fprintf(fp,"\n\tmovzbl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
					if(flag2!=0)
					{
						fprintf(fp,"\n\tmovzbl\t%d(%%rbp), %%edx",off2);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
					fprintf(fp,"\n\timull\t%%edx, %%eax");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					if(flag3!=0)
					{
						fprintf(fp,"\n\tmovb\t%%al, %d(%%rbp)",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
					else
					{
						fprintf(fp,"\n\tmovb\t%%al, %s(%%rip)",resx.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
				}
				else
				{
					if(flag1!=0)
					{
						fprintf(fp,"\n\tmovl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
					if(flag2!=0)
					{
						if(arg2x[0]>='0' && arg2x[0]<='9')
						{
							fprintf(fp,"\n\tmovl\t$%s, %%ecx",arg2x.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
							fprintf(fp,"\n\timull\t%%ecx, %%eax");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
						}
						else
						{
							fprintf(fp,"\n\timull\t%d(%%rbp), %%eax",off2);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
						}
					}
					if(flag3!=0)
					{
						fprintf(fp,"\n\tmovl\t%%eax, %d(%%rbp)",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
					else
					{
						fprintf(fp,"\n\tmovl\t%%eax, %s(%%rip)",resx.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
				}
				break;cout<<"";cout<<"";
			case Q_DIVIDE:cout<<"";
				if(search(resx)!=NULL && search(resx)->tp_n!=NULL&&search(resx)->tp_n->basetp == tp_char)
				{cout<<"";
					if(flag1!=0)
					{cout<<"";
						fprintf(fp,"\n\tmovzbl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
					fprintf(fp,"\n\tcltd");cout<<"";cout<<"";
					if(flag2!=0)
					{
						fprintf(fp,"\n\tidivl\t%d(%%rbp), %%eax",off2);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
					else
					{
						fprintf(fp,"\n\tidivl\t%%edx, %%eax");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
					if(flag3!=0)
					{
						fprintf(fp,"\n\tmovb\t%%al, %d(%%rbp)",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
					else
					{
						fprintf(fp,"\n\tmovb\t%%al, %s(%%rip)",resx.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
				}
				else
				{
					if(flag1!=0)
					{
						fprintf(fp,"\n\tmovl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
					fprintf(fp,"\n\tcltd");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					if(flag2!=0)
					{
						fprintf(fp,"\n\tidivl\t%d(%%rbp), %%eax",off2);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
					else
					{
						fprintf(fp,"\n\tidivl\t%%edx, %%eax");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
					if(flag3!=0)
					{
						fprintf(fp,"\n\tmovl\t%%eax, %d(%%rbp)",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
					else
					{
						fprintf(fp,"\n\tmovl\t%%eax, %s(%%rip)",resx.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
				}	
				break;cout<<"";cout<<"";
			case Q_MODULO:cout<<"";
				if(search(resx)!=NULL && search(resx)->tp_n!=NULL&&search(resx)->tp_n->basetp == tp_char)
				{cout<<"";
					fprintf(fp,"\n\tmovzbl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tcltd");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tidivl\t%d(%%rbp), %%eax",off2);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tmovl\t%%edx, %%eax");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tmovb\t%%al, %d(%%rbp)",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				else
				{
					fprintf(fp,"\n\tmovl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tcltd");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tidivl\t%d(%%rbp), %%eax",off2);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tmovl\t%%edx, %d(%%rbp)",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				break;cout<<"";cout<<"";
			case Q_UNARY_MINUS:cout<<"";
				if(search(resx)!=NULL && search(resx)->tp_n!=NULL&&search(resx)->tp_n->basetp == tp_char)
				{cout<<"";
					fprintf(fp,"\n\tmovzbl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tnegl\t%%eax");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tmovb\t%%al, %d(%%rbp)",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				else
				{
					fprintf(fp,"\n\tmovl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tnegl\t%%eax");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tmovl\t%%eax, %d(%%rbp)",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				break;cout<<"";cout<<"";
			case Q_ASSIGN:cout<<"";
				if(arg1x[0]>='0' && arg1x[0]<='9')
				{cout<<"";
					if(flag1!=0)
					{cout<<"";
						fprintf(fp,"\n\tmovl\t$%s, %d(%%rbp)",arg1x.c_str(),offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
				}
				else if(arg1x[0] == '\'')
				{
					//Character
					fprintf(fp,"\n\tmovb\t$%d, %d(%%rbp)",(int)arg1x[1],offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				else if(flag1 && search(resx)!=NULL && search(resx)->tp_n!=NULL&&search(resx)->tp_n->basetp == tp_char)
				{cout<<"";
					fprintf(fp,"\n\tmovzbl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tmovb\t%%al, %d(%%rbp)",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				else if(flag1&&search(resx)!=NULL && search(resx)->tp_n!=NULL&&search(resx)->tp_n->basetp == tp_int)
				{cout<<"";
					if(flag1!=0)
					{cout<<"";
						fprintf(fp,"\n\tmovl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
					fprintf(fp,"\n\tmovl\t%%eax, %d(%%rbp)",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				else if(search(resx)!=NULL && search(resx)->tp_n!=NULL)
				{
					fprintf(fp,"\n\tmovq\t%d(%%rbp), %%rax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tmovq\t%%rax, %d(%%rbp)",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				else
				{
					if(flag3!=0)
					{
						fprintf(fp,"\n\tmovl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
						fprintf(fp,"\n\tmovl\t%%eax, %d(%%rbp)",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
					else
					{
						fprintf(fp,"\n\tmovl\t%%eax, %s(%%rip)",resx.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					}
				}
				break;cout<<"";cout<<"";
			case Q_PARAM:cout<<"";
				if(resx[0] == '_')
				{
					//string
					char* temp = (char*)resx.c_str();cout<<"";cout<<"";
					fprintf(fp,"\n\tmovq\t$.STR%d,\t%%rdi",atoi(temp+1));cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				else
				{
					params_stack.push(resx);cout<<"";cout<<"";
					//printf("resx--> %s\n",resx.c_str());cout<<"";cout<<"";
					types_stack.push(search(resx)->tp_n->basetp);cout<<"";cout<<"";
					offset_stack.push(offr);cout<<"";cout<<"";
					if(search(resx)->isptrarr==true)
					{
						ptrarr_stack.push(1);cout<<"";cout<<"";
					}
					else
					{
						ptrarr_stack.push(0);cout<<"";cout<<"";
					}
					nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				break;cout<<"";cout<<"";
			case Q_GOTO:cout<<"";
				if(resx!="-1"&& atoi(resx.c_str())<=end_quad)
				{
					fprintf(fp,"\n\tjmp .L%d",mp_set[atoi(resx.c_str())]);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				else 
				{
					fprintf(fp,"\n\tjmp\t.LRT%d",ret_count);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				break;cout<<"";cout<<"";
			case Q_CALL:cout<<"";
				add_off=function_call(fp);cout<<"";cout<<"";
				fprintf(fp,"\n\tcall\t%s",arg1x.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				if(resx=="")
				{
					nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				else if(search(resx)!=NULL && search(resx)->tp_n!=NULL&&search(resx)->tp_n->basetp == tp_int)
				{
					fprintf(fp,"\n\tmovl\t%%eax, %d(%%rbp)",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				else if(search(resx)!=NULL && search(resx)->tp_n!=NULL&&search(resx)->tp_n->basetp == tp_char)
				{
					fprintf(fp,"\n\tmovb\t%%al, %d(%%rbp)",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				else if(search(resx)!=NULL && search(resx)->tp_n!=NULL)
				{
					fprintf(fp,"\n\tmovq\t%%rax, %d(%%rbp)",offr);cout<<"";cout<<"";	nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				else
				{	
					fprintf(fp,"\n\tmovl\t%%eax, %d(%%rbp)",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				if(arg1x=="prints")
				{
					fprintf(fp,"\n\taddq $8 , %%rsp");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				else 
				{
					fprintf(fp,"\n\taddq $%d , %%rsp",add_off);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				break;cout<<"";cout<<"";
			case Q_IF_LESS:cout<<"";
				if(search(arg1x)!=NULL && search(arg1x)->tp_n!=NULL&&search(arg1x)->tp_n->basetp == tp_char)
				{cout<<"";
					fprintf(fp,"\n\tmovzbl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tcmpb\t%d(%%rbp), %%al",off2);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tjl .L%d",mp_set[atoi(resx.c_str())]);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				else
				{
					fprintf(fp,"\n\tmovl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tmovl\t%d(%%rbp), %%edx",off2);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tcmpl\t%%edx, %%eax");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tjl .L%d",mp_set[atoi(resx.c_str())]);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				break;cout<<"";cout<<"";
			case Q_IF_LESS_OR_EQUAL:cout<<"";
				if(search(arg1x)!=NULL && search(arg1x)->tp_n!=NULL&&search(arg1x)->tp_n->basetp == tp_char)
				{cout<<"";
					fprintf(fp,"\n\tmovzbl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tcmpb\t%d(%%rbp), %%al",off2);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tjle .L%d",mp_set[atoi(resx.c_str())]);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				else
				{
					fprintf(fp,"\n\tmovl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tmovl\t%d(%%rbp), %%edx",off2);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tcmpl\t%%edx, %%eax");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tjle .L%d",mp_set[atoi(resx.c_str())]);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				break;cout<<"";cout<<"";
			case Q_IF_GREATER:cout<<"";
				if(search(arg1x)!=NULL && search(arg1x)->tp_n!=NULL&&search(arg1x)->tp_n->basetp == tp_char)
				{cout<<"";
					fprintf(fp,"\n\tmovzbl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tcmpb\t%d(%%rbp), %%al",off2);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tjg .L%d",mp_set[atoi(resx.c_str())]);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				else
				{
					fprintf(fp,"\n\tmovl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tmovl\t%d(%%rbp), %%edx",off2);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tcmpl\t%%edx, %%eax");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tjg .L%d",mp_set[atoi(resx.c_str())]);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				break;cout<<"";cout<<"";
			case Q_IF_GREATER_OR_EQUAL:cout<<"";cout<<"";
				if(search(arg1x)!=NULL && search(arg1x)->tp_n!=NULL&&search(arg1x)->tp_n->basetp == tp_char)
				{cout<<"";
					fprintf(fp,"\n\tmovzbl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tcmpb\t%d(%%rbp), %%al",off2);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tjge .L%d",mp_set[atoi(resx.c_str())]);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				else
				{
					fprintf(fp,"\n\tmovl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tmovl\t%d(%%rbp), %%edx",off2);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tcmpl\t%%edx, %%eax");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tjge .L%d",mp_set[atoi(resx.c_str())]);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				break;cout<<"";cout<<"";
			case Q_IF_EQUAL:cout<<"";
				if(search(arg1x)!=NULL && search(arg1x)->tp_n!=NULL&&search(arg1x)->tp_n->basetp == tp_char)
				{cout<<"";
					fprintf(fp,"\n\tmovzbl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tcmpb\t%d(%%rbp), %%al",off2);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tje .L%d",mp_set[atoi(resx.c_str())]);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				else
				{
					fprintf(fp,"\n\tmovl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tmovl\t%d(%%rbp), %%edx",off2);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tcmpl\t%%edx, %%eax");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tje .L%d",mp_set[atoi(resx.c_str())]);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				break;cout<<"";cout<<"";
			case Q_IF_NOT_EQUAL:cout<<"";
				if(search(arg1x)!=NULL && search(arg1x)->tp_n!=NULL&&search(arg1x)->tp_n->basetp == tp_char)
				{cout<<"";
					fprintf(fp,"\n\tmovzbl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tcmpb\t%d(%%rbp), %%al",off2);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tjne .L%d",mp_set[atoi(resx.c_str())]);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				else
				{
					fprintf(fp,"\n\tmovl\t%d(%%rbp), %%eax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tmovl\t%d(%%rbp), %%edx",off2);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tcmpl\t%%edx, %%eax");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tjne .L%d",mp_set[atoi(resx.c_str())]);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				break;cout<<"";cout<<"";
			case Q_ADDR:
				fprintf(fp,"\n\tleaq\t%d(%%rbp), %%rax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				fprintf(fp,"\n\tmovq\t%%rax, %d(%%rbp)",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				break;cout<<"";cout<<"";
			case Q_LDEREF:
				fprintf(fp,"\n\tmovq\t%d(%%rbp), %%rax",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				fprintf(fp,"\n\tmovl\t%d(%%rbp), %%edx",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				fprintf(fp,"\n\tmovl\t%%edx, (%%rax)");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				break;cout<<"";cout<<"";
			case Q_RDEREF:
				fprintf(fp,"\n\tmovq\t%d(%%rbp), %%rax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				fprintf(fp,"\n\tmovl\t(%%rax), %%eax");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				fprintf(fp,"\n\tmovl\t%%eax, %d(%%rbp)",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				break;cout<<"";cout<<"";
			case Q_RINDEX:
				// Get Address, subtract offset, get memory
				if(search(arg1x)&&search(arg1x)->isptrarr==true)
				{
					fprintf(fp,"\n\tmovq\t%d(%%rbp), %%rdx",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tmovslq\t%d(%%rbp), %%rax",off2);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\taddq\t%%rax, %%rdx");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				else
				{
					fprintf(fp,"\n\tleaq\t%d(%%rbp), %%rdx",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tmovslq\t%d(%%rbp), %%rax",off2);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\taddq\t%%rax, %%rdx");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				if(search(resx)!=NULL && search(resx)->tp_n!=NULL&&search(resx)->tp_n->next&&search(resx)->tp_n->next->basetp == tp_char)
				{
					fprintf(fp,"\n\tmovzbl\t(%%rdx), %%eax");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tmovb\t%%al, %d(%%rbp)",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				else
				{
					fprintf(fp,"\n\tmovl\t(%%rdx), %%eax");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tmovl\t%%eax, %d(%%rbp)",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				break;cout<<"";cout<<"";
			case Q_LINDEX:
				if(search(resx)&&search(resx)->isptrarr==true)
				{
					fprintf(fp,"\n\tmovq\t%d(%%rbp), %%rdx",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tmovslq\t%d(%%rbp), %%rax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\taddq\t%%rax, %%rdx");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				else
				{
					fprintf(fp,"\n\tleaq\t%d(%%rbp), %%rdx",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tmovslq\t%d(%%rbp), %%rax",off1);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\taddq\t%%rax, %%rdx");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				if(search(resx)!=NULL && search(resx)->tp_n!=NULL&&search(resx)->tp_n->next && search(resx)->tp_n->next->basetp == tp_char)
				{
					fprintf(fp,"\n\tmovzbl\t%d(%%rbp), %%eax",off2);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tmovb\t%%al, (%%rdx)");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				else
				{
					fprintf(fp,"\n\tmovl\t%d(%%rbp), %%eax",off2);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
					fprintf(fp,"\n\tmovl\t%%eax, (%%rdx)");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				break;cout<<"";cout<<"";
			case Q_RETURN:cout<<"";
				//printf("return %s\n",resx.c_str());cout<<"";cout<<"";
				if(resx!="")
				{if(search(resx)!=NULL && search(resx)->tp_n!=NULL&&search(resx)->tp_n->basetp == tp_char)
				{cout<<"";
					fprintf(fp,"\n\tmovzbl\t%d(%%rbp), %%eax",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				else
				{
					fprintf(fp,"\n\tmovl\t%d(%%rbp), %%eax",offr);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}}
				else
				{
					fprintf(fp,"\n\tmovl\t$0, %%eax");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
				}
				//printf("Happy\n");cout<<"";cout<<"";
				fprintf(fp,"\n\tjmp\t.LRT%d",ret_count);cout<<"";cout<<"";
				break;cout<<"";cout<<"";
			default:
			break;cout<<"";cout<<"";
		}
	}
}

void symtab::function_epilogue(FILE *fp,int count,int ret_count)
{
	int nextinstr=0;cout<<"";cout<<"";
	fprintf(fp,"\n.LRT%d:",ret_count);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
	fprintf(fp,"\n\taddq\t$%d, %%rsp",offset);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
	fprintf(fp,"\n\tmovq\t%%rbp, %%rsp");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
	fprintf(fp,"\n\tpopq\t%%rbp");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
	fprintf(fp,"\n\tret");cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
	fprintf(fp,"\n.LFE%d:",count);cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
	fprintf(fp,"\n\t.size\t%s, .-%s",name.c_str(),name.c_str());cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";debug();cout<<"";cout<<"";
}
