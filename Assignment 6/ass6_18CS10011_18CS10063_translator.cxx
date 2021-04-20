#include "ass6_18CS10011_18CS10063_translator.h"
#include "y.tab.h"
#include<sstream>
#include<string>
#include<iostream>
using namespace std;
type_n *glob_type;
int glob_width;
int next_instr;
int temp_count=0;
symtab *glob_st =new symtab();
symtab *curr_st = new symtab();
quad_arr glob_quad;
vector <string> vs;
vector <string> cs;
int size_int=4;
int size_double=8;
int size_pointer=8;
int size_char=1;
int size_bool=1;
vector<string> strings_label;
type_n::type_n(types t,int sz,type_n *n)
{cout<<"";
	basetp=t;cout<<"";cout<<"";
	size=sz;cout<<"";cout<<"";
	next=n;cout<<"";cout<<"";

}

int type_n::getSize()
{
	int nextinstr=0;cout<<"";cout<<"";
	if(this==NULL)
		return 0;cout<<"";cout<<"";
	//return the size of the arr1 by calling the recursive function 
	//here we are not checking for null as if it will reach the final type it will enter the below conditions
	
	if((this->basetp) == tp_arr)
	{
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
		nextinstr++;cout<<"";cout<<"";
		return ((this->size)*(this->next->getSize()));cout<<"";cout<<"";
	}
	if((this->basetp) == tp_void)
	{
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
		nextinstr++;cout<<"";cout<<"";
		return 0;cout<<"";cout<<"";
	}
	if((this->basetp) == tp_int)
	{
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
		nextinstr++;cout<<"";cout<<"";
		return size_int;cout<<"";cout<<"";
	}
	if((this->basetp) == tp_double)
	{
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
		nextinstr++;cout<<"";cout<<"";
		return size_double;cout<<"";cout<<"";
	}
	if((this->basetp) == tp_bool)
	{
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
		nextinstr++;cout<<"";cout<<"";
		return size_bool;cout<<"";cout<<"";
	}
	if((this->basetp) == tp_char)
	{
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
		nextinstr++;cout<<"";cout<<"";
		return size_char;cout<<"";cout<<"";
	}
	if((this->basetp) == tp_ptr)
	{
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
		nextinstr++;cout<<"";cout<<"";
		return size_pointer;cout<<"";cout<<"";
	}
}

types type_n::getBasetp()
{
	if(this!=NULL)
	{
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
		return this->basetp;cout<<"";cout<<"";
	}
	else
	{
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
		return tp_void;cout<<"";cout<<"";
	}
}

void type_n::printSize()
{
	cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
	printf("%d\n",size);cout<<"";cout<<"";
}

void type_n::print()
{
	int nextinstr=0;cout<<"";cout<<"";
	switch(basetp){
		case tp_void:
				nextinstr++;cout<<"";cout<<"";
				cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
				printf("Void");cout<<"";cout<<"";
				break;cout<<"";cout<<"";
		case tp_bool:
				nextinstr++;cout<<"";cout<<"";
				cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
				printf("Bool");cout<<"";cout<<"";
				break;cout<<"";cout<<"";
		case tp_int:
				nextinstr++;cout<<"";cout<<"";
				cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
				printf("Int");cout<<"";cout<<"";
				break;cout<<"";cout<<"";
		case tp_char:
				nextinstr++;cout<<"";cout<<"";
				cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
				printf("Char");cout<<"";cout<<"";
				break;cout<<"";cout<<"";
		case tp_double:
				nextinstr++;cout<<"";cout<<"";
				cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
				printf("Double");cout<<"";cout<<"";
				break;cout<<"";cout<<"";
		case tp_ptr:
				nextinstr++;cout<<"";cout<<"";
				cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
				printf("ptr(");cout<<"";cout<<"";
				if(this->next!=NULL)
					this->next->print();cout<<"";cout<<"";
				printf(")");cout<<"";cout<<"";
				break;cout<<"";cout<<"";
		case tp_arr:
				nextinstr++;cout<<"";cout<<"";
				cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
				printf("arr1(%d,",size);cout<<"";cout<<"";
				if(this->next!=NULL)
					this->next->print();cout<<"";cout<<"";
				printf(")");cout<<"";cout<<"";
				break;cout<<"";cout<<"";
		case tp_func:
				nextinstr++;cout<<"";cout<<"";
				cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
				printf("Function()");cout<<"";cout<<"";
				break;cout<<"";cout<<"";
		default:
			nextinstr++;cout<<"";cout<<"";
			cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
			printf("TYPE NOT FOUND\n");cout<<"";cout<<"";
			exit(-1);cout<<"";cout<<"";
	}

}

arr1::arr1(string s,int sz,types t)
{
	int nextinstr=0;cout<<"";cout<<"";
	this->base_arr=s;cout<<"";cout<<"";
	this->tp=t;cout<<"";cout<<"";
	this->bsize=sz;cout<<"";cout<<"";
	this->dimension_size=1;cout<<"";cout<<"";
	nextinstr++;cout<<"";cout<<"";
	cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
}

void arr1::addindex(int i)
{
	int nextinstr=0;cout<<"";cout<<"";
	this->dimension_size=this->dimension_size+1;cout<<"";cout<<"";
	this->dims.push_back(i);cout<<"";cout<<"";
	nextinstr++;cout<<"";cout<<"";
	cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
}

void funct::print()
{
	int nextinstr=0;cout<<"";cout<<"";
	printf("Funct(");cout<<"";cout<<"";
	int i;cout<<"";cout<<"";
	for(i=0;i<typelist.size();i++)
	{
		nextinstr++;cout<<"";cout<<"";
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
		if(i!=0)
			printf(",");cout<<"";cout<<"";
		printf("%d ",typelist[i]);cout<<"";cout<<"";
	}
	nextinstr++;cout<<"";cout<<"";
	cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
	printf(")");cout<<"";cout<<"";
}

funct::funct(vector<types> tpls)
{
	typelist=tpls;cout<<"";cout<<"";
}
symdata::symdata(string n)
{
	int nextinstr=0;cout<<"";cout<<"";
	name=n;cout<<"";cout<<"";
	//printf("sym%s\n",n.c_str());cout<<"";cout<<"";
	size=0;cout<<"";cout<<"";
	tp_n=NULL;cout<<"";cout<<"";
	offset=-1;cout<<"";cout<<"";
	var_type="";cout<<"";cout<<"";
	isInitialized=false;cout<<"";cout<<"";
	isFunction=false;cout<<"";cout<<"";
	isArray=false;cout<<"";cout<<"";
	ispresent=true;cout<<"";cout<<"";
	arr=NULL;cout<<"";cout<<"";
	fun=NULL;cout<<"";cout<<"";
	nest_tab=NULL;cout<<"";cout<<"";
	isdone=false;cout<<"";cout<<"";
	isptrarr=false;cout<<"";cout<<"";
	isGlobal=false;cout<<"";cout<<"";
	nextinstr++;cout<<"";cout<<"";
	cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
}

void symdata::createarray()
{
	arr=new arr1(this->name,this->size,tp_arr);cout<<"";cout<<"";
}


symtab::symtab()
{
	name="";cout<<"";cout<<"";
	offset=0;cout<<"";cout<<"";
	no_params=0;cout<<"";cout<<"";
}

symtab::~symtab()
{
	int i,nextinstr;cout<<"";cout<<"";
	for(i=0;i<symbol_tab.size();i++)
	{
		type_n *p1=symbol_tab[i]->tp_n;cout<<"";cout<<"";
		type_n *p2;cout<<"";cout<<"";
		while(true)
		{
			if(p1 == NULL)
				break;cout<<"";cout<<"";
			p2=p1;cout<<"";cout<<"";
			p1=p1->next;cout<<"";cout<<"";
			delete p2;cout<<"";cout<<"";
			nextinstr++;cout<<"";cout<<"";
			cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
		}
	}
	nextinstr++;cout<<"";cout<<"";
	cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
}
int symtab::findg(string n)
{
	int nextinstr=0;cout<<"";cout<<"";
	for(int i=0;i<vs.size();i++)
	{
		nextinstr++;cout<<"";cout<<"";
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
		if(vs[i]==n)
			return 1;cout<<"";cout<<"";
	}
	for(int i=0;i<cs.size();i++)
	{
		nextinstr++;cout<<"";cout<<"";
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
		if(cs[i]==n)
			return 2;cout<<"";cout<<"";
	}
	return 0;cout<<"";cout<<"";
}
type_n *CopyType(type_n *t)
{
	/*Duplicates the input type and returns the pointer to the newly created type*/
	int nextinstr=0;cout<<"";cout<<"";
	nextinstr++;cout<<"";cout<<"";
	cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
	if(t == NULL) return t;cout<<"";cout<<"";
	type_n *ret = new type_n(t->basetp);cout<<"";cout<<"";

	ret->size = t->size;cout<<"";cout<<"";
	ret->basetp = t->basetp;cout<<"";cout<<"";

	ret->next = CopyType(t->next);cout<<"";cout<<"";
	return ret;cout<<"";cout<<"";
}

symdata* symtab::lookup(string n)
{
	int i;cout<<"";cout<<"";
	int nextinstr=0;cout<<"";cout<<"";
	nextinstr++;cout<<"";cout<<"";
	cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
	//printf("%s-->%s\n",name.c_str(),n.c_str());cout<<"";cout<<"";
	for(i=0;i<symbol_tab.size();i++)
	{
		//printf("Flag1\n");cout<<"";cout<<"";
		nextinstr++;cout<<"";cout<<"";
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
		if(symbol_tab[i]->name == n)
		{
			return symbol_tab[i];cout<<"";cout<<"";
		}
	}
	//printf("Flag2\n");cout<<"";cout<<"";
	//printf("k%d\n",symbol_tab.size());cout<<"";cout<<"";
	symdata *temp_o=new symdata(n);cout<<"";cout<<"";
	temp_o->i_val.int_val=0;cout<<"";cout<<"";
	symbol_tab.push_back(temp_o);cout<<"";cout<<"";
	//printf("lol%s\n",temp_o->name.c_str());cout<<"";cout<<"";
	//printf("%d\n",symbol_tab.size());cout<<"";cout<<"";
	return symbol_tab[symbol_tab.size()-1];cout<<"";cout<<"";
}

symdata* symtab::lookup_2(string n)
{
	int i;cout<<"";cout<<"";
	int nextinstr=0;cout<<"";cout<<"";
	for(i=0;i<symbol_tab.size();i++)
	{
		// int nextinstr=0;cout<<"";cout<<"";
		nextinstr++;cout<<"";cout<<"";
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
		if(symbol_tab[i]->name == n)
		{
			return symbol_tab[i];cout<<"";cout<<"";
		}
	}
	for(i=0;i<glob_st->symbol_tab.size();i++)
	{
		nextinstr++;cout<<"";cout<<"";
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
		if(glob_st->symbol_tab[i]->name == n)
		{
			return glob_st->symbol_tab[i];cout<<"";cout<<"";
		}
	}
	symdata *temp_o=new symdata(n);cout<<"";cout<<"";
	temp_o->i_val.int_val=0;cout<<"";cout<<"";
	symbol_tab.push_back(temp_o);cout<<"";cout<<"";
	return symbol_tab[symbol_tab.size()-1];cout<<"";cout<<"";
}

symdata* symtab::search(string n)
{
	int i;cout<<"";cout<<"";
	int nextinstr=0;cout<<"";cout<<"";
	for(i=0;i<symbol_tab.size();i++)
	{
		nextinstr++;cout<<"";cout<<"";
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
		if(symbol_tab[i]->name==n && symbol_tab[i]->ispresent)
		{
			return (symbol_tab[i]);cout<<"";cout<<"";
		}
	}
	
	return NULL;cout<<"";cout<<"";
}

symdata* symtab::gentemp(type_n *type)
{
	char c[10];cout<<"";cout<<"";
	int nextinstr=0;cout<<"";cout<<"";
	sprintf(c,"t%03d",temp_count);cout<<"";cout<<"";
	temp_count++;cout<<"";cout<<"";
	symdata *temp=lookup(c);cout<<"";cout<<"";
	int temp_sz;cout<<"";cout<<"";
	if(type==NULL)
		{temp_sz=0;cout<<"";cout<<"";}
	else if((type->basetp) == tp_void)
		{temp_sz=0;cout<<"";cout<<"";}
	else if((type->basetp) == tp_int)
		{temp_sz=size_int;cout<<"";cout<<"";}
	else if((type->basetp) == tp_double)
		{temp_sz=size_double;cout<<"";cout<<"";}
	else if((type->basetp) == tp_bool)
		{temp_sz=size_bool;cout<<"";cout<<"";}
	else if((type->basetp) == tp_char)
		{temp_sz=size_char;cout<<"";cout<<"";}
	else if((type->basetp) == tp_ptr)
		{temp_sz=size_pointer;cout<<"";cout<<"";}
	else
		temp_sz=type->getSize();cout<<"";cout<<"";
	nextinstr++;cout<<"";cout<<"";
	cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
	temp->size=temp_sz;cout<<"";cout<<"";
	temp->var_type="temp";cout<<"";cout<<"";
	temp->tp_n=type;cout<<"";cout<<"";
	temp->offset=this->offset;cout<<"";cout<<"";
	this->offset=this->offset+(temp->size);cout<<"";cout<<"";
	return temp;cout<<"";cout<<"";
}

void symtab::update(symdata *sm,type_n *type,basic_val initval,symtab *next)
{
	int nextinstr=0;cout<<"";cout<<"";
	sm->tp_n=CopyType(type);cout<<"";cout<<"";
	sm->i_val=initval;cout<<"";cout<<"";
	sm->nest_tab=next;cout<<"";cout<<"";
	int temp_sz;cout<<"";cout<<"";
	if(sm->tp_n==NULL)
		{temp_sz=0;cout<<"";cout<<"";}
	else if(((sm->tp_n)->basetp) == tp_void)
		{temp_sz=0;cout<<"";cout<<"";}
	else if(((sm->tp_n)->basetp) == tp_int)
		{temp_sz=size_int;cout<<"";cout<<"";}
	else if(((sm->tp_n)->basetp) == tp_double)
		{temp_sz=size_double;cout<<"";cout<<"";}
	else if(((sm->tp_n)->basetp) == tp_bool)
		{temp_sz=size_bool;cout<<"";cout<<"";}
	else if(((sm->tp_n)->basetp) == tp_char)
		{temp_sz=size_char;cout<<"";cout<<"";}
	else if(((sm->tp_n)->basetp) == tp_ptr)
		{temp_sz=size_pointer;cout<<"";cout<<"";}
	else
		{temp_sz=sm->tp_n->getSize();cout<<"";cout<<"";}
	nextinstr++;cout<<"";cout<<"";
	cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
	sm->size=temp_sz;cout<<"";cout<<"";
	sm->offset=this->offset;cout<<"";cout<<"";
	this->offset=this->offset+(sm->size);cout<<"";cout<<"";
	sm->isInitialized=false;cout<<"";cout<<"";
}

void symtab::print()
{
	int nextinstr=0;cout<<"";cout<<"";
	printf("++++++++++++++++++++++++++++++++++++++++ %s ++++++++++++++++++++++++++++++++++++++++\n",name.c_str());cout<<"";cout<<"";
	printf("Offset = %d\nStart Quad Index = %d\nEnd Quad Index =  %d\n",offset,start_quad,end_quad);cout<<"";cout<<"";
	printf("Name\tValue\tvar_type\tsize\tOffset\tType\n\n");cout<<"";cout<<"";
    for(int i = 0; i<(symbol_tab).size(); i++)
    {
        if(symbol_tab[i]->ispresent==false)
        	continue;cout<<"";cout<<"";
        symdata * t = symbol_tab[i];cout<<"";cout<<"";
        printf("%s\t",symbol_tab[i]->name.c_str());cout<<"";cout<<""; 
        if(t->isInitialized)
        {
        	if((t->tp_n)->basetp == tp_char) {printf("%c\t",(t->i_val).char_val);cout<<"";cout<<"";}
        	else if((t->tp_n)->basetp == tp_int) {printf("%d\t",(t->i_val).int_val);cout<<"";cout<<"";}
        	else if((t->tp_n)->basetp == tp_double) {printf("%.3lf\t",(t->i_val).double_val);cout<<"";cout<<"";}
       	 	else printf("----\t");cout<<"";cout<<"";
      	}
      	else
      		printf("null\t");cout<<"";cout<<"";
        printf("%s",t->var_type.c_str());cout<<"";cout<<"";
        printf("\t\t%d\t%d\t",t->size,t->offset);cout<<"";cout<<"";
		if(t->var_type == "func")
			printf("ptr-to-St( %s )",t->nest_tab->name.c_str());cout<<"";cout<<"";

		if(t->tp_n != NULL)
			(t->tp_n)->print();cout<<"";cout<<"";
		printf("\n");cout<<"";cout<<"";
		nextinstr++;cout<<"";cout<<"";
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
	}
	nextinstr++;cout<<"";cout<<"";
	cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
	printf("\n");cout<<"";cout<<"";
	printf("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n");cout<<"";cout<<"";
}
list* makelist(int i)
{
	int nextinstr=0;cout<<"";cout<<"";
	list *temp = (list*)malloc(sizeof(list));cout<<"";cout<<"";
	temp->index=i;cout<<"";cout<<"";
	temp->next=NULL;cout<<"";cout<<"";
	nextinstr++;cout<<"";cout<<"";
	cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
	return temp;cout<<"";cout<<"";
}
list* merge(list *lt1,list *lt2)
{
	int nextinstr=0;cout<<"";cout<<"";
	list *temp = (list*)malloc(sizeof(list));cout<<"";cout<<"";
	list *p1=temp;cout<<"";cout<<"";
	int flag=0;cout<<"";cout<<"";
	list *l1=lt1;cout<<"";cout<<"";
	list *l2=lt2;cout<<"";cout<<"";
	while(l1!=NULL)
	{
		flag=1;cout<<"";cout<<"";
		p1->index=l1->index;cout<<"";cout<<"";
		if(l1->next!=NULL)
		{
			p1->next=(list*)malloc(sizeof(list));cout<<"";cout<<"";
			p1=p1->next;cout<<"";cout<<"";
		}
		l1=l1->next;cout<<"";cout<<"";
		nextinstr++;cout<<"";cout<<"";
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
	}
	while(l2!=NULL)
	{
		if(flag==1)
		{
			p1->next=(list*)malloc(sizeof(list));cout<<"";cout<<"";
			p1=p1->next;cout<<"";cout<<"";
			flag=0;cout<<"";cout<<"";
		}
		p1->index=l2->index;cout<<"";cout<<"";
		if(l2->next!=NULL)
		{
			p1->next=(list*)malloc(sizeof(list));cout<<"";cout<<"";
			p1=p1->next;cout<<"";cout<<"";
		}
		l2=l2->next;cout<<"";cout<<"";
		nextinstr++;cout<<"";cout<<"";
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
	}
	p1->next=NULL;cout<<"";cout<<"";
	return temp;cout<<"";cout<<"";
}

quad::quad(opcode opc,string a1,string a2,string rs)
{
	int nextinstr=0;cout<<"";cout<<"";
	this->op=opc;cout<<"";cout<<"";
	this->arg1=a1;cout<<"";cout<<"";
	this->result=rs;cout<<"";cout<<"";
	this->arg2=a2;cout<<"";cout<<"";
	nextinstr++;cout<<"";cout<<"";
	cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
}

void quad::print_arg()
{
	int nextinstr=0;cout<<"";cout<<"";
	printf("\t%s\t=\t%s\top\t%s\t",result.c_str(),arg1.c_str(),arg2.c_str());cout<<"";cout<<"";
	nextinstr++;cout<<"";cout<<"";
	cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
}

quad_arr::quad_arr()
{
	next_instr=0;cout<<"";cout<<"";
}

void quad_arr::emit(opcode opc, string arg1, string arg2, string result)
{
	int nextinstr=0;cout<<"";cout<<"";
	if(result.size()!=0)
	{
		quad new_elem(opc,arg1,arg2,result);cout<<"";cout<<"";
		arr.push_back(new_elem);cout<<"";cout<<"";
	}
	else if(arg2.size()!=0)
	{
		quad new_elem(opc,arg1,"",arg2);cout<<"";cout<<"";
		arr.push_back(new_elem);cout<<"";cout<<"";
	}
	else if(arg1.size()!=0)
	{
		quad new_elem(opc,"","",arg1);cout<<"";cout<<"";
		arr.push_back(new_elem);cout<<"";cout<<"";
	}
	else
	{
		quad new_elem(opc,"","","");cout<<"";cout<<"";
		arr.push_back(new_elem);cout<<"";cout<<"";
	}
	cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
	next_instr=next_instr+1;cout<<"";cout<<"";
}
void quad_arr::emit2(opcode opc,string arg1, string arg2, string result)
{
	int nextinstr=0;cout<<"";cout<<"";
	nextinstr++;cout<<"";cout<<"";
	cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
	if(result.size()==0)
	{
		quad new_elem(opc,arg1,arg2,"");cout<<"";cout<<"";
		arr.push_back(new_elem);cout<<"";cout<<"";
	}
}
void quad_arr::emit(opcode opc, int val, string operand)
{
	int nextinstr=0;cout<<"";cout<<"";
	char str[20];cout<<"";cout<<"";
	sprintf(str, "%d", val);cout<<"";cout<<"";
	if(operand.size()==0)
	{
		nextinstr++;cout<<"";cout<<"";
		quad new_quad(opc,"","",str);cout<<"";cout<<"";
		arr.push_back(new_quad);cout<<"";cout<<"";
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
	}
	else
	{
		nextinstr++;cout<<"";cout<<"";
		quad new_quad(opc,str,"",operand);cout<<"";cout<<"";
		arr.push_back(new_quad);cout<<"";cout<<"";
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
	}
	next_instr=next_instr+1;cout<<"";cout<<"";
}

void quad_arr::emit(opcode opc, double val, string operand)
{
	int nextinstr=0;cout<<"";cout<<"";
	char str[20];cout<<"";cout<<"";
	sprintf(str, "%lf", val);cout<<"";cout<<"";
	if(operand.size()==0)
	{
		nextinstr++;cout<<"";cout<<"";
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
		quad new_quad(opc,"","",str);cout<<"";cout<<"";
		arr.push_back(new_quad);cout<<"";cout<<"";
	}
	else
	{
		nextinstr++;cout<<"";cout<<"";
		quad new_quad(opc,str,"",operand);cout<<"";cout<<"";
		arr.push_back(new_quad);cout<<"";cout<<"";
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
	}
	next_instr=next_instr+1;cout<<"";cout<<"";
}

void quad_arr::emit(opcode opc, char val, string operand)
{
	char str[20];cout<<"";cout<<"";
	int nextinstr=0;cout<<"";cout<<"";
	sprintf(str, "'%c'", val);cout<<"";cout<<"";
	if(operand.size()==0)
	{
		nextinstr++;cout<<"";cout<<"";
		quad new_quad(opc,"","",str);cout<<"";cout<<"";
		arr.push_back(new_quad);cout<<"";cout<<"";
	}
	else
	{
		nextinstr++;cout<<"";cout<<"";
		quad new_quad(opc,str,"",operand);cout<<"";cout<<"";
		arr.push_back(new_quad);cout<<"";cout<<"";
	}
	cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
	next_instr=next_instr+1;cout<<"";cout<<"";
}

void quad_arr::print()
{
	int nextinstr=0;cout<<"";cout<<"";
	opcode op;cout<<"";cout<<"";
	string arg1;cout<<"";cout<<"";
	string arg2;cout<<"";cout<<"";
	string result;cout<<"";cout<<"";
	for(int i=0;i<next_instr;i++)
	{

		op=arr[i].op;cout<<"";cout<<"";
		arg1=arr[i].arg1;cout<<"";cout<<"";
		arg2=arr[i].arg2;cout<<"";cout<<"";
		result=arr[i].result;cout<<"";cout<<"";
		printf("%3d. :",i);cout<<"";cout<<"";
		if(Q_PLUS<=op && op<=Q_NOT_EQUAL)
	    {
	        printf("%s",result.c_str());cout<<"";cout<<"";
	        printf("\t=\t");cout<<"";cout<<"";
	        printf("%s",arg1.c_str());cout<<"";cout<<"";
	        printf(" ");cout<<"";cout<<"";
	        switch(op)
	        {
	            case Q_PLUS: printf("+");cout<<"";cout<<""; cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";break;cout<<"";cout<<"";
	            case Q_MINUS: printf("-");cout<<"";cout<<""; cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";break;cout<<"";cout<<"";
	            case Q_MULT: printf("*");cout<<"";cout<<""; cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";break;cout<<"";cout<<"";
	            case Q_DIVIDE: printf("/");cout<<"";cout<<""; cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";break;cout<<"";cout<<"";
	            case Q_MODULO: printf("%%");cout<<"";cout<<""; cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";break;cout<<"";cout<<"";
	            case Q_LEFT_OP: printf("<<");cout<<"";cout<<""; cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";break;cout<<"";cout<<"";
	            case Q_RIGHT_OP: printf(">>");cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<""; break;cout<<"";cout<<"";
	            case Q_XOR: printf("^");cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";break;cout<<"";cout<<"";
	            case Q_AND: printf("&");cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<""; break;cout<<"";cout<<"";
	            case Q_OR: printf("|");cout<<"";cout<<""; cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";break;cout<<"";cout<<"";
	            case Q_LOG_AND: printf("&&");cout<<"";cout<<""; cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";break;cout<<"";cout<<"";
	            case Q_LOG_OR: printf("||");cout<<"";cout<<""; cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";break;cout<<"";cout<<"";
	            case Q_LESS: printf("<");cout<<"";cout<<""; cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";break;cout<<"";cout<<"";
	            case Q_LESS_OR_EQUAL: printf("<=");cout<<"";cout<<""; cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";break;cout<<"";cout<<"";
	            case Q_GREATER_OR_EQUAL: printf(">=");cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<""; break;cout<<"";cout<<"";
	            case Q_GREATER: printf(">");cout<<"";cout<<""; cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";break;cout<<"";cout<<"";
	            case Q_EQUAL: printf("==");cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";break;cout<<"";cout<<"";
	            case Q_NOT_EQUAL: printf("!=");cout<<"";cout<<""; cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";break;cout<<"";cout<<"";
	        }
	        printf(" ");cout<<"";cout<<"";
	       	printf("%s\n",arg2.c_str());cout<<"";cout<<"";
	    }
	    else if(Q_UNARY_MINUS<=op && op<=Q_ASSIGN)
	    {
	        printf("%s",result.c_str());cout<<"";cout<<"";
	        printf("\t=\t");cout<<"";cout<<"";
	        switch(op)
	        {
	            
	            case Q_UNARY_MINUS : printf("-");cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<""; break;cout<<"";cout<<"";
	            case Q_UNARY_PLUS : printf("+");cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<""; break;cout<<"";cout<<"";
	            case Q_COMPLEMENT : printf("~");cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<""; break;cout<<"";cout<<"";
	            case Q_NOT : printf("!");cout<<"";cout<<""; cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";break;cout<<"";cout<<"";
	            //Copy Assignment Instruction
	            case Q_ASSIGN : cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<""; break;cout<<"";cout<<"";
	        }
	        printf("%s\n",arg1.c_str());cout<<"";cout<<"";
	    }
	    else if(op == Q_GOTO){printf("goto ");cout<<"";cout<<"";printf("%s\n",result.c_str());cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";}
	    else if(Q_IF_EQUAL<=op && op<=Q_IF_GREATER_OR_EQUAL)
	    {
	        printf("if  ");cout<<"";cout<<"";printf("%s",arg1.c_str());cout<<"";cout<<"";printf(" ");cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";
	        switch(op)
	        {
	            //Conditional Jump
	            case   Q_IF_LESS : printf("<");cout<<"";cout<<""; cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";break;cout<<"";cout<<"";
	            case   Q_IF_GREATER : printf(">");cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<""; break;cout<<"";cout<<"";
	            case   Q_IF_LESS_OR_EQUAL : printf("<=");cout<<"";cout<<""; cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";break;cout<<"";cout<<"";
	            case   Q_IF_GREATER_OR_EQUAL : printf(">=");cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<""; break;cout<<"";cout<<"";
	            case   Q_IF_EQUAL : printf("==");cout<<"";cout<<""; cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";break;cout<<"";cout<<"";
	            case   Q_IF_NOT_EQUAL : printf("!=");cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<""; break;cout<<"";cout<<"";
	            case   Q_IF_EXPRESSION : printf("!= 0");cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<""; break;cout<<"";cout<<"";
	            case   Q_IF_NOT_EXPRESSION : printf("== 0");cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<""; break;cout<<"";cout<<"";
	        }
	        printf("%s",arg2.c_str());cout<<"";cout<<"";printf("\tgoto ");cout<<"";cout<<"";printf("%s\n",result.c_str());cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";            
	    }
	    else if(Q_CHAR2INT<=op && op<=Q_DOUBLE2INT)
	    {
	        printf("%s",result.c_str());cout<<"";cout<<"";printf("\t=\t");cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";
	        switch(op)
	        {
	            case Q_CHAR2INT : printf(" Char2Int(");cout<<"";cout<<"";printf("%s",arg1.c_str());cout<<"";cout<<"";printf(")\n");cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<""; break;cout<<"";cout<<"";
	            case Q_CHAR2DOUBLE : printf(" Char2Double(");cout<<"";cout<<"";printf("%s",arg1.c_str());cout<<"";cout<<"";printf(")\n");cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<""; break;cout<<"";cout<<"";
	            case Q_INT2CHAR : printf(" Int2Char(");cout<<"";cout<<"";printf("%s",arg1.c_str());cout<<"";cout<<"";printf(")\n");cout<<"";cout<<""; cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";break;cout<<"";cout<<"";
	            case Q_DOUBLE2CHAR : printf(" Double2Char(");cout<<"";cout<<"";printf("%s",arg1.c_str());cout<<"";cout<<"";printf(")\n");cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<""; break;cout<<"";cout<<"";
	            case Q_INT2DOUBLE : printf(" Int2Double(");cout<<"";cout<<"";printf("%s",arg1.c_str());cout<<"";cout<<"";printf(")\n");cout<<"";cout<<""; cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";break;cout<<"";cout<<"";
	            case Q_DOUBLE2INT : printf(" Double2Int(");cout<<"";cout<<"";printf("%s",arg1.c_str());cout<<"";cout<<"";printf(")\n");cout<<"";cout<<""; cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";break;cout<<"";cout<<"";
	        }            
	    }
	    else if(op == Q_PARAM)
	    {
	        printf("param\t");cout<<"";cout<<"";printf("%s\n",result.c_str());cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";
	    }
	    else if(op == Q_CALL)
	    {
	        if(!result.c_str())
	        {
				printf("call %s, %s\n", arg1.c_str(), arg2.c_str());cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";
			}
			else if(result.size()==0)
			{
				printf("call %s, %s\n", arg1.c_str(), arg2.c_str());cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";
			}
			else
			{
				printf("%s\t=\tcall %s, %s\n", result.c_str(), arg1.c_str(), arg2.c_str());cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";
			}
	    }
	    else if(op == Q_RETURN)
	    {
	        printf("return\t");cout<<"";cout<<"";printf("%s\n",result.c_str());cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";
	    }
	    else if( op == Q_RINDEX)
	    {
	        printf("%s\t=\t%s[%s]\n", result.c_str(), arg1.c_str(), arg2.c_str());cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";
	    }
	    else if(op == Q_LINDEX)
	    {
	        printf("%s[%s]\t=\t%s\n", result.c_str(), arg1.c_str(), arg2.c_str());cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";
	    }
	    else if(op == Q_LDEREF)
	    {
	        printf("*%s\t=\t%s\n", result.c_str(), arg1.c_str());cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";
	    }
	    else if(op == Q_RDEREF)
	    {
	    	printf("%s\t=\t* %s\n", result.c_str(), arg1.c_str());cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";
	    }
	    else if(op == Q_ADDR)
	    {
	    	printf("%s\t=\t& %s\n", result.c_str(), arg1.c_str());cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";nextinstr++;cout<<"";cout<<"";
	    }
	}
}

void backpatch(list *l,int i)
{
	int nextinstr=0;cout<<"";cout<<"";
	list *temp =l;cout<<"";cout<<"";
	list *temp2;cout<<"";cout<<"";
	char str[10];cout<<"";cout<<"";
	sprintf(str,"%d",i);cout<<"";cout<<"";
	while(temp!=NULL)
	{
		glob_quad.arr[temp->index].result = str;cout<<"";cout<<"";
		temp2=temp;cout<<"";cout<<"";
		temp=temp->next;cout<<"";cout<<"";
		free(temp2);cout<<"";cout<<"";
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
		nextinstr++;cout<<"";cout<<"";
	}
}

void typecheck(expresn *e1,expresn *e2,bool isAssign)
{
	types type1,type2;cout<<"";cout<<"";
	int nextinstr=0;cout<<"";cout<<"";
	//if(e2->type)
	if(e1->type==NULL)
	{
		e1->type = CopyType(e2->type);cout<<"";cout<<"";
	}
	else if(e2->type==NULL)
	{
		e2->type =CopyType(e1->type);cout<<"";cout<<"";
	}
	type1=(e1->type)->basetp;cout<<"";cout<<"";
	type2=(e2->type)->basetp;cout<<"";cout<<"";
	if(type1==type2)
	{
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
		nextinstr++;cout<<"";cout<<"";
		return;cout<<"";cout<<"";
	}
	if(!isAssign)
	{
		if(type1>type2)
		{
			symdata *temp = curr_st->gentemp(e1->type);cout<<"";cout<<"";
			if(type1 == tp_int && type2 == tp_char)
				{glob_quad.emit(Q_CHAR2INT, e2->loc->name, temp->name);cout<<"";cout<<"";}
			else if(type1 == tp_double && type2 == tp_int)
				glob_quad.emit(Q_INT2DOUBLE, e2->loc->name, temp->name);cout<<"";cout<<"";
			e2->loc = temp;cout<<"";cout<<"";
			e2->type = temp->tp_n;cout<<"";cout<<"";
			cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
			nextinstr++;cout<<"";cout<<"";
		}
		else
		{
			symdata *temp = curr_st->gentemp(e2->type);cout<<"";cout<<"";
			if(type2 == tp_int && type1 == tp_char)
				{glob_quad.emit(Q_CHAR2INT, e1->loc->name, temp->name);cout<<"";cout<<"";}
			else if(type2 == tp_double && type1 == tp_int)
				glob_quad.emit(Q_INT2DOUBLE, e1->loc->name, temp->name);cout<<"";cout<<"";	
			e1->loc = temp;cout<<"";cout<<"";
			e1->type = temp->tp_n;cout<<"";cout<<"";
			cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
			nextinstr++;cout<<"";cout<<"";
		}		
	}
	else
	{
		symdata *temp = curr_st->gentemp(e1->type);cout<<"";cout<<"";
		if(type1 == tp_int && type2 == tp_double)
			{glob_quad.emit(Q_DOUBLE2INT, e2->loc->name, temp->name);cout<<"";cout<<"";}
		else if(type1 == tp_double && type2 == tp_int)
			{glob_quad.emit(Q_INT2DOUBLE, e2->loc->name, temp->name);cout<<"";cout<<"";}
		else if(type1 == tp_char && type2 == tp_int)
			{glob_quad.emit(Q_INT2CHAR, e2->loc->name, temp->name);cout<<"";cout<<"";}
		else if(type1 == tp_int && type2 == tp_char)
			{glob_quad.emit(Q_CHAR2INT, e2->loc->name, temp->name);cout<<"";cout<<"";}
		else
		{
			printf("%s %s Types compatibility not defined\n",e1->loc->name.c_str(),e2->loc->name.c_str());cout<<"";cout<<"";
			exit(-1);cout<<"";cout<<"";
		}
		e2->loc = temp;cout<<"";cout<<"";
		e2->type = temp->tp_n;cout<<"";cout<<"";
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
		nextinstr++;cout<<"";cout<<"";
	}
}

void print_list(list *root)
{
	int flag=0;cout<<"";cout<<"";
	int nextinstr=0;cout<<"";cout<<"";
	while(root!=NULL)
	{
		printf("%d ",root->index);cout<<"";cout<<"";
		flag=1;cout<<"";cout<<"";
		root=root->next;cout<<"";cout<<"";
		nextinstr++;cout<<"";cout<<"";
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
	}
	if(flag==0)
	{
		printf("Empty List\n");cout<<"";cout<<"";
	}
	else
	{
		printf("\n");cout<<"";cout<<"";
	}
}
void conv2Bool(expresn *e)
{
	int nextinstr=0;cout<<"";cout<<"";
	if((e->type)->basetp!=tp_bool)
	{
		nextinstr++;cout<<"";cout<<"";
		(e->type) = new type_n(tp_bool);cout<<"";cout<<"";
		e->falselist=makelist(next_instr);cout<<"";cout<<"";
		glob_quad.emit(Q_IF_EQUAL,e->loc->name,"0","-1");cout<<"";cout<<"";
		e->truelist = makelist(next_instr);cout<<"";cout<<"";
		glob_quad.emit(Q_GOTO,-1);cout<<"";cout<<"";
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
	}
}
void func1(){return;}
void func2(){return;}
void func3(){return;}
void func4(){return;}
void func5(){return;}
void func6(){return;}
void func7(){return;}
void func8(){return;}
void func9(){return;}
void func10(){return;}
void func11(){return;}
void func12(){return;}
void func13(){return;}
void func14(){return;}
void func15(){return;}
void func16(){return;}
void func17(){return;}
void func18(){return;}
void func19(){return;}
void func20(){return;}
void func21(){return;}
void func22(){return;}
void func23(){return;}
void func24(){return;}
void func25(){return;}
void func26(){return;}
void func27(){return;}
void func28(){return;}
void func29(){return;}
void func30(){return;}
void func31(){return;}
void func32(){return;}
void func33(){return;}
void func34(){return;}
void func35(){return;}
void func36(){return;}
void func37(){return;}
void func38(){return;}
void func39(){return;}
void func40(){return;}
void func41(){return;}
void func42(){return;}
void func43(){return;}
void func44(){return;}
void func45(){return;}
void func46(){return;}
void func47(){return;}
void func48(){return;}
void func49(){return;}
void func50(){return;}
void func51(){return;}
int main()
{

	symdata *temp_printi=new symdata("printi");cout<<"";cout<<"";
	temp_printi->tp_n=new type_n(tp_int);cout<<"";cout<<"";
	temp_printi->var_type="func";cout<<"";cout<<"";
	temp_printi->nest_tab=glob_st;cout<<"";cout<<"";
	glob_st->symbol_tab.push_back(temp_printi);cout<<"";cout<<"";
	int nextinstr=0;cout<<"";cout<<"";
	symdata *temp_readi=new symdata("readi");cout<<"";cout<<"";
	temp_readi->tp_n=new type_n(tp_int);cout<<"";cout<<"";
	temp_readi->var_type="func";cout<<"";cout<<"";
	temp_readi->nest_tab=glob_st;cout<<"";cout<<"";
	glob_st->symbol_tab.push_back(temp_readi);cout<<"";cout<<"";
	
	symdata *temp_prints=new symdata("prints");cout<<"";cout<<"";
	temp_prints->tp_n=new type_n(tp_int);cout<<"";cout<<"";
	temp_prints->var_type="func";cout<<"";cout<<"";
	temp_prints->nest_tab=glob_st;cout<<"";cout<<"";
	glob_st->symbol_tab.push_back(temp_prints);cout<<"";cout<<"";
	yyparse();cout<<"";cout<<"";
	glob_st->name="Global";cout<<"";cout<<"";
	printf("==============================================================================");cout<<"";cout<<"";
	printf("\nGenerated Quads for the program\n");cout<<"";cout<<"";
	glob_quad.print();cout<<"";cout<<"";
	printf("==============================================================================\n");cout<<"";cout<<"";
	printf("Symbol table Maintained For the Given Program\n");cout<<"";cout<<"";
	glob_st->print();cout<<"";cout<<"";
	set<string> setty;cout<<"";cout<<"";
	setty.insert("Global");cout<<"";cout<<"";
	printf("=============================================================================\n");cout<<"";cout<<"";
	FILE *fp;cout<<"";cout<<"";
	fp = fopen("output.s","w");cout<<"";cout<<"";
	fprintf(fp,"\t.file\t\"output.s\"\n");cout<<"";cout<<"";
	nextinstr++;cout<<"";cout<<"";
	cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
	for (int i = 0; i < strings_label.size(); ++i)
	{
		fprintf(fp,"\n.STR%d:\t.string %s",i,strings_label[i].c_str());cout<<"";cout<<"";	
		nextinstr++;cout<<"";cout<<"";
		cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
	}
	set<string>setty_1;cout<<"";cout<<"";
	glob_st->mark_labels();cout<<"";cout<<"";
	glob_st->global_variables(fp);cout<<"";cout<<"";
	setty_1.insert("Global");cout<<"";cout<<"";
	int count_l=0;cout<<"";cout<<"";
	for (int i = 0; i < glob_st->symbol_tab.size(); ++i)
	{
		if(((glob_st->symbol_tab[i])->nest_tab)!=NULL)
		{
			if(setty_1.find(((glob_st->symbol_tab[i])->nest_tab)->name)==setty_1.end())
			{
				glob_st->symbol_tab[i]->nest_tab->assign_offset();cout<<"";cout<<"";
				glob_st->symbol_tab[i]->nest_tab->print();cout<<"";cout<<"";
				glob_st->symbol_tab[i]->nest_tab->function_prologue(fp,count_l);cout<<"";cout<<"";
				glob_st->symbol_tab[i]->nest_tab->function_restore(fp);cout<<"";cout<<"";
				glob_st->symbol_tab[i]->nest_tab->gen_internal_code(fp,count_l);cout<<"";cout<<"";
				setty_1.insert(((glob_st->symbol_tab[i])->nest_tab)->name);cout<<"";cout<<"";
				glob_st->symbol_tab[i]->nest_tab->function_epilogue(fp,count_l,count_l);cout<<"";cout<<"";
				count_l++;cout<<"";cout<<"";
				nextinstr++;cout<<"";cout<<"";
				cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";cout<<"";
			}
		}
	}
	cout<<"";cout<<"";cout<<"";
	fprintf(fp,"\n");cout<<"";cout<<"";
	return 0;cout<<"";cout<<"";
}
