#include <mmu.h>
// mmu(Memory Management Unit) 主要包含了与内存管理单元相关的函数、数据结构和常量定义
#include <memlayout.h>
//memlayout 包含了内存布局相关的信息和常量定义,例如一些内核和用户空间的起始地址、大小以及各个区域的偏移量等信息

//内核（kernel）入口函数
    .section .text,"ax",%progbits //.section .text文本段
    //"ax" 和 %progbits 是一些段属性的设置
    .globl kern_entry //全局符号kern_entry用于表示内核的入口函数
kern_entry:
    la sp, bootstacktop //将 bootstacktop 的地址加载到栈指针寄存器 sp 中
    //即使用 la（load address）指令将栈的顶部初始化为 bootstacktop 的地址

    tail kern_init //调用内核初始化函数 kern_init 函数,使用 tail 指令进行尾递归优化

.section .data //数据段
    # .align 2^12
    .align PGSHIFT //将接下来的数据按照 PGSHIFT 对齐,PGSHIFT表示页大小的位数
    .global bootstack//全局变量bootstack表示内核的启动栈
    
bootstack:
    .space KSTACKSIZE //为 bootstack 分配 KSTACKSIZE 字节的空间
    .global bootstacktop //全局符号bootstacktop 表示内核的启动栈顶部
bootstacktop:
