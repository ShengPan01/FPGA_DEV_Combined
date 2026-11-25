/*
 * Copyright (c) 2026 . All rights reserved.
 *
 * Unauthorized copying, modification, distribution, or use
 * of this software is strictly prohibited without prior
 * written permission from the copyright owner.
 *
 * Author: 
 * Date: 2026-11-11
 */
#include <string.h>
#include "config.h"
#include "sal.h"
#include "cmdline.h"
#include "cmd_sys.h"
#include "custom_test.h"

#include "typedef.h"



#ifdef CMD_LINE_DEBUG

char argc;
char *argv[5];

// only support lower case
// int hex_to_int(char *s)
// {
//     int r;
//     char c;
//
//     r = 0;
//     while (c=*s)
//     {
//         r = (r << 4) + c;
//         if (c <= '9')
//             r = r - '0';
//         else
//             r = r - 87;   // - 'a' + 10
//         s++;
//     }
//     return r;
// }

long hex_to_long(char *s)
{
    long r;
    char c;

    r = 0;
    while (*s)
    {
        c = *s;
        r = (r << 4) + c;
        if (c <= '9')
            r = r - '0';
        else
            r = r - 87;   // - 'a' + 10
        s++;
    }
    return r;
}

void decode_term_str(void)
{
    char *s;
    char space;

    s = command_buf;
    argc = 0;
    if (*s)
    {
            space = 0;
            argv[(int)(argc++)] = s;
            while (*s)
        {
                if (*s == ' ')
            {
                        *s = 0; //change SPACE to NULL
                        if (!space)
                {
                            space = 1;
                        }
                }
            else
            {
                        if (space && argc < 5)
                                argv[(int)(argc++)] = s;
                        space = 0;
                }
                s++;
            }
    }

}

u1 search_proc_cmd(const cmd_t *cmds, void (*funcs[])(char **argv), u8 n_cmds, u8 argc, char **argv)
{
    u8 i, j;
    const cmd_t *cmd;
    void (*f)(char **argv);

    for (i=0; i<n_cmds; i++) {
        cmd = cmds+i;
        if (argc == 0) {
            debug_printf("%s\t", cmd->cmd_name, cmd->help);
            for (j=0; j<(2-(strlen(cmd->cmd_name)>>3)); j++)
                debug_printf("\t");
            debug_printf("%s\n", cmd->help);
        } else if (strcmp(cmd->cmd_name, argv[0]) == 0) {
            if (cmd->n_argument == (argc-1)) {
                f = funcs[i];
                f(argv);
            } else
                debug_printf("Usage: %s %s\n", cmd->cmd_name, (cmd->arguments) ? cmd->arguments : "");
            return TRUE;
        }
    }
    return FALSE;
}

void proc_term_cmd(void)
{
    //debug_printf("cmd\n");
    if (argc == 0)
        return;
    else if (!strcmp(argv[0], "help")) {
        debug_printf("-help-\n");
        if (argc > 1) {
            search_proc_cmd(sys_cmds, NULL, sys_n_cmds, 99, &(argv[1]));
            search_proc_cmd(custom_test_cmds, NULL, custom_test_n_cmds, 99, &(argv[1]));
        } else {
            debug_printf("--- system command ---\n");
            search_proc_cmd(sys_cmds, NULL, sys_n_cmds, 0, NULL);
            debug_printf("--- custom test command ---\n");
            search_proc_cmd(custom_test_cmds, NULL, custom_test_n_cmds, 0, NULL);
        }
    } else if (search_proc_cmd(sys_cmds, sys_funcs, sys_n_cmds, argc, argv)) {
    } else if (search_proc_cmd(custom_test_cmds, custom_test_funcs, custom_test_n_cmds, argc, argv)) {
    } else
        debug_printf("unsupported cmd: %s\n", argv[0]);
}

void CommandProcess(void)
{
    if (term_cmd_valid)
    {
        //putchar_local(0x42);
        term_cmd_valid = 0;
        command_buf[command_buf_len] = 0; //add a trailing NULL
        enable_debug_output = 1;
        decode_term_str();
        proc_term_cmd();
    }
}
#endif
