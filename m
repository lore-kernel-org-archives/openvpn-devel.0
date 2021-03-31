MIME-Version: 1.0
References: <1616991798-7179-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1616991798-7179-1-git-send-email-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 31 Mar 2021 17:34:53 +0300
Message-ID: <CAGyAFMV-crxbDc09NWwVhQ+6nyyhA+HhPSa1GDJeCurzFE+5Gw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Remove automatic service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Selva <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Patch looks fine, apart missing change to VS project:

diff --git a/src/openvpnserv/openvpnserv.vcxproj
b/src/openvpnserv/openvpnserv.vcxproj
index 5e973df4..d0f210ad 100644
--- a/src/openvpnserv/openvpnserv.vcxproj
+++ b/src/openvpnserv/openvpnserv.vcxproj
@@ -115,7 +115,6 @@
     </Link>
   </ItemDefinitionGroup>
   <ItemGroup>
-    <ClCompile Include="automatic.c" />
     <ClCompile Include="common.c" />
     <ClCompile Include="interactive.c" />
     <ClCompile Include="service.c" />
diff --git a/src/openvpnserv/openvpnserv.vcxproj.filters
b/src/openvpnserv/openvpnserv.vcxproj.filters
index 41ad3e80..389dac31 100644
--- a/src/openvpnserv/openvpnserv.vcxproj.filters
+++ b/src/openvpnserv/openvpnserv.vcxproj.filters
@@ -18,9 +18,6 @@
     <ClCompile Include="service.c">
       <Filter>Source Files</Filter>
     </ClCompile>
-    <ClCompile Include="automatic.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
     <ClCompile Include="common.c">
       <Filter>Source Files</Filter>
     </ClCompile>

I checked MSI and NSIS installers in openvpn-build. MSI installer
doesn't touch automatic service so we're good. NSIS installer script,
however, has a code which
installs "OpenVPNServiceLegacy", so we will have to update it.

I built and tested an NSIS installer with that patch and smoke-tested
on Windows 10. If Gert can modify VS project with the above diff,
consider it as an ACK from me.

ma 29. maalisk. 2021 klo 7.24 selva.nair@...277... kirjoitti:
>
> From: Selva Nair <selva.nair@...277...>
>
> This has been replaced by openvpnserv2 since 2.4.0 and we have
> stopped setting up this service in the installer since 2.5.0.
>
> Get rid of the unused code. The mechanics of supporting multiple
> services with the same executable is retained for possible future use.
>
> For backwards compatibility, the command line option -instance
> is unchanged as "-instance <name> id" although <name>="interactive"
> is the only supported value now.
>
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpnserv/Makefile.am |   1 -
>  src/openvpnserv/automatic.c | 434 --------------------------------------------
>  src/openvpnserv/service.c   |  46 +++--
>  src/openvpnserv/service.h   |   6 -
>  4 files changed, 21 insertions(+), 466 deletions(-)
>  delete mode 100644 src/openvpnserv/automatic.c
>
> diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
> index 5dc38c9..3e69125 100644
> --- a/src/openvpnserv/Makefile.am
> +++ b/src/openvpnserv/Makefile.am
> @@ -31,7 +31,6 @@ endif
>
>  openvpnserv_SOURCES = \
>          common.c \
> -       automatic.c \
>         interactive.c \
>         service.c service.h \
>         validate.c validate.h \
> diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c
> deleted file mode 100644
> index 0ba222a..0000000
> --- a/src/openvpnserv/automatic.c
> +++ /dev/null
> @@ -1,434 +0,0 @@
> -/*
> - *  OpenVPN -- An application to securely tunnel IP networks
> - *             over a single TCP/UDP port, with support for SSL/TLS-based
> - *             session authentication and key exchange,
> - *             packet encryption, packet authentication, and
> - *             packet compression.
> - *
> - *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License version 2
> - *  as published by the Free Software Foundation.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License along
> - *  with this program; if not, write to the Free Software Foundation, Inc.,
> - *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - */
> -
> -/*
> - * This program allows one or more OpenVPN processes to be started
> - * as a service.  To build, you must get the service sample from the
> - * Platform SDK and replace Simple.c with this file.
> - *
> - * You should also apply service.patch to
> - * service.c and service.h from the Platform SDK service sample.
> - *
> - * This code is designed to be built with the mingw compiler.
> - */
> -
> -#include "service.h"
> -
> -#include <stdio.h>
> -#include <stdarg.h>
> -#include <stdbool.h>
> -#include <process.h>
> -
> -static SERVICE_STATUS_HANDLE service;
> -static SERVICE_STATUS status = { .dwServiceType = SERVICE_WIN32_SHARE_PROCESS };
> -
> -openvpn_service_t automatic_service = {
> -    automatic,
> -    TEXT(PACKAGE_NAME "ServiceLegacy"),
> -    TEXT(PACKAGE_NAME " Legacy Service"),
> -    TEXT(SERVICE_DEPENDENCIES),
> -    SERVICE_DEMAND_START
> -};
> -
> -struct security_attributes
> -{
> -    SECURITY_ATTRIBUTES sa;
> -    SECURITY_DESCRIPTOR sd;
> -};
> -
> -static HANDLE exit_event = NULL;
> -
> -/* clear an object */
> -#define CLEAR(x) memset(&(x), 0, sizeof(x))
> -
> -
> -bool
> -init_security_attributes_allow_all(struct security_attributes *obj)
> -{
> -    CLEAR(*obj);
> -
> -    obj->sa.nLength = sizeof(SECURITY_ATTRIBUTES);
> -    obj->sa.lpSecurityDescriptor = &obj->sd;
> -    obj->sa.bInheritHandle = TRUE;
> -    if (!InitializeSecurityDescriptor(&obj->sd, SECURITY_DESCRIPTOR_REVISION))
> -    {
> -        return false;
> -    }
> -    if (!SetSecurityDescriptorDacl(&obj->sd, TRUE, NULL, FALSE))
> -    {
> -        return false;
> -    }
> -    return true;
> -}
> -
> -HANDLE
> -create_event(LPCTSTR name, bool allow_all, bool initial_state, bool manual_reset)
> -{
> -    if (allow_all)
> -    {
> -        struct security_attributes sa;
> -        if (!init_security_attributes_allow_all(&sa))
> -        {
> -            return NULL;
> -        }
> -        return CreateEvent(&sa.sa, (BOOL)manual_reset, (BOOL)initial_state, name);
> -    }
> -    else
> -    {
> -        return CreateEvent(NULL, (BOOL)manual_reset, (BOOL)initial_state, name);
> -    }
> -}
> -
> -void
> -close_if_open(HANDLE h)
> -{
> -    if (h != NULL)
> -    {
> -        CloseHandle(h);
> -    }
> -}
> -
> -static bool
> -match(const WIN32_FIND_DATA *find, LPCTSTR ext)
> -{
> -    if (find->dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
> -    {
> -        return false;
> -    }
> -
> -    if (*ext == TEXT('\0'))
> -    {
> -        return true;
> -    }
> -
> -    /* find the pointer to that last '.' in filename and match ext against the rest */
> -
> -    const TCHAR *p = _tcsrchr(find->cFileName, TEXT('.'));
> -    return p && p != find->cFileName && _tcsicmp(p + 1, ext) == 0;
> -}
> -
> -/*
> - * Modify the extension on a filename.
> - */
> -static bool
> -modext(LPTSTR dest, size_t size, LPCTSTR src, LPCTSTR newext)
> -{
> -    size_t i;
> -
> -    if (size > 0 && (_tcslen(src) + 1) <= size)
> -    {
> -        _tcscpy_s(dest, size, src);
> -        dest [size - 1] = TEXT('\0');
> -        i = _tcslen(dest);
> -        while (i-- > 0)
> -        {
> -            if (dest[i] == TEXT('\\'))
> -            {
> -                break;
> -            }
> -            if (dest[i] == TEXT('.'))
> -            {
> -                dest[i] = TEXT('\0');
> -                break;
> -            }
> -        }
> -        if (_tcslen(dest) + _tcslen(newext) + 2 <= size)
> -        {
> -            _tcscat_s(dest, size, TEXT("."));
> -            _tcscat_s(dest, size, newext);
> -            return true;
> -        }
> -        dest[0] = TEXT('\0');
> -    }
> -    return false;
> -}
> -
> -static DWORD WINAPI
> -ServiceCtrlAutomatic(DWORD ctrl_code, DWORD event, LPVOID data, LPVOID ctx)
> -{
> -    SERVICE_STATUS *status = ctx;
> -    switch (ctrl_code)
> -    {
> -        case SERVICE_CONTROL_STOP:
> -            status->dwCurrentState = SERVICE_STOP_PENDING;
> -            ReportStatusToSCMgr(service, status);
> -            if (exit_event)
> -            {
> -                SetEvent(exit_event);
> -            }
> -            return NO_ERROR;
> -
> -        case SERVICE_CONTROL_INTERROGATE:
> -            return NO_ERROR;
> -
> -        default:
> -            return ERROR_CALL_NOT_IMPLEMENTED;
> -    }
> -}
> -
> -
> -VOID WINAPI
> -ServiceStartAutomaticOwn(DWORD dwArgc, LPTSTR *lpszArgv)
> -{
> -    status.dwServiceType = SERVICE_WIN32_OWN_PROCESS;
> -    ServiceStartAutomatic(dwArgc, lpszArgv);
> -}
> -
> -
> -VOID WINAPI
> -ServiceStartAutomatic(DWORD dwArgc, LPTSTR *lpszArgv)
> -{
> -    DWORD error = NO_ERROR;
> -    settings_t settings;
> -    TCHAR event_name[256];
> -
> -    service = RegisterServiceCtrlHandlerEx(automatic_service.name, ServiceCtrlAutomatic, &status);
> -    if (!service)
> -    {
> -        return;
> -    }
> -
> -    status.dwCurrentState = SERVICE_START_PENDING;
> -    status.dwServiceSpecificExitCode = NO_ERROR;
> -    status.dwWin32ExitCode = NO_ERROR;
> -    status.dwWaitHint = 3000;
> -
> -    if (!ReportStatusToSCMgr(service, &status))
> -    {
> -        MsgToEventLog(M_ERR, TEXT("ReportStatusToSCMgr #1 failed"));
> -        goto finish;
> -    }
> -
> -    /*
> -     * Create our exit event
> -     * This event is initially created in the non-signaled
> -     * state.  It will transition to the signaled state when
> -     * we have received a terminate signal from the Service
> -     * Control Manager which will cause an asynchronous call
> -     * of ServiceStop below.
> -     */
> -
> -    openvpn_sntprintf(event_name, _countof(event_name), TEXT(PACKAGE "%s_exit_1"), service_instance);
> -    exit_event = create_event(event_name, false, false, true);
> -    if (!exit_event)
> -    {
> -        MsgToEventLog(M_ERR, TEXT("CreateEvent failed"));
> -        goto finish;
> -    }
> -
> -    /*
> -     * If exit event is already signaled, it means we were not
> -     * shut down properly.
> -     */
> -    if (WaitForSingleObject(exit_event, 0) != WAIT_TIMEOUT)
> -    {
> -        MsgToEventLog(M_ERR, TEXT("Exit event is already signaled -- we were not shut down properly"));
> -        goto finish;
> -    }
> -
> -    if (!ReportStatusToSCMgr(service, &status))
> -    {
> -        MsgToEventLog(M_ERR, TEXT("ReportStatusToSCMgr #2 failed"));
> -        goto finish;
> -    }
> -
> -    /*
> -     * Read info from registry in key HKLM\SOFTWARE\OpenVPN
> -     */
> -    error = GetOpenvpnSettings(&settings);
> -    if (error != ERROR_SUCCESS)
> -    {
> -        goto finish;
> -    }
> -
> -    /*
> -     * Instantiate an OpenVPN process for each configuration
> -     * file found.
> -     */
> -    {
> -        WIN32_FIND_DATA find_obj;
> -        HANDLE find_handle;
> -        BOOL more_files;
> -        TCHAR find_string[MAX_PATH];
> -
> -        openvpn_sntprintf(find_string, _countof(find_string), TEXT("%s\\*"), settings.config_dir);
> -
> -        find_handle = FindFirstFile(find_string, &find_obj);
> -        if (find_handle == INVALID_HANDLE_VALUE)
> -        {
> -            MsgToEventLog(M_ERR, TEXT("Cannot get configuration file list using: %s"), find_string);
> -            goto finish;
> -        }
> -
> -        /*
> -         * Loop over each config file
> -         */
> -        do
> -        {
> -            HANDLE log_handle = NULL;
> -            STARTUPINFO start_info;
> -            PROCESS_INFORMATION proc_info;
> -            struct security_attributes sa;
> -            TCHAR log_file[MAX_PATH];
> -            TCHAR log_path[MAX_PATH];
> -            TCHAR command_line[256];
> -
> -            CLEAR(start_info);
> -            CLEAR(proc_info);
> -            CLEAR(sa);
> -
> -            if (!ReportStatusToSCMgr(service, &status))
> -            {
> -                MsgToEventLog(M_ERR, TEXT("ReportStatusToSCMgr #3 failed"));
> -                FindClose(find_handle);
> -                goto finish;
> -            }
> -
> -            /* does file have the correct type and extension? */
> -            if (match(&find_obj, settings.ext_string))
> -            {
> -                /* get log file pathname */
> -                if (!modext(log_file, _countof(log_file), find_obj.cFileName, TEXT("log")))
> -                {
> -                    MsgToEventLog(M_ERR, TEXT("Cannot construct logfile name based on: %s"), find_obj.cFileName);
> -                    FindClose(find_handle);
> -                    goto finish;
> -                }
> -                openvpn_sntprintf(log_path, _countof(log_path),
> -                                  TEXT("%s\\%s"), settings.log_dir, log_file);
> -
> -                /* construct command line */
> -                openvpn_sntprintf(command_line, _countof(command_line), TEXT("openvpn --service \"" PACKAGE "%s_exit_1\" 1 --config \"%s\""),
> -                                  service_instance,
> -                                  find_obj.cFileName);
> -
> -                /* Make security attributes struct for logfile handle so it can
> -                 * be inherited. */
> -                if (!init_security_attributes_allow_all(&sa))
> -                {
> -                    error = MsgToEventLog(M_SYSERR, TEXT("InitializeSecurityDescriptor start_" PACKAGE " failed"));
> -                    goto finish;
> -                }
> -
> -                /* open logfile as stdout/stderr for soon-to-be-spawned subprocess */
> -                log_handle = CreateFile(log_path,
> -                                        GENERIC_WRITE,
> -                                        FILE_SHARE_READ,
> -                                        &sa.sa,
> -                                        settings.append ? OPEN_ALWAYS : CREATE_ALWAYS,
> -                                        FILE_ATTRIBUTE_NORMAL,
> -                                        NULL);
> -
> -                if (log_handle == INVALID_HANDLE_VALUE)
> -                {
> -                    error = MsgToEventLog(M_SYSERR, TEXT("Cannot open logfile: %s"), log_path);
> -                    FindClose(find_handle);
> -                    goto finish;
> -                }
> -
> -                /* append to logfile? */
> -                if (settings.append)
> -                {
> -                    if (SetFilePointer(log_handle, 0, NULL, FILE_END) == INVALID_SET_FILE_POINTER)
> -                    {
> -                        error = MsgToEventLog(M_SYSERR, TEXT("Cannot seek to end of logfile: %s"), log_path);
> -                        FindClose(find_handle);
> -                        goto finish;
> -                    }
> -                }
> -
> -                /* fill in STARTUPINFO struct */
> -                GetStartupInfo(&start_info);
> -                start_info.cb = sizeof(start_info);
> -                start_info.dwFlags = STARTF_USESTDHANDLES|STARTF_USESHOWWINDOW;
> -                start_info.wShowWindow = SW_HIDE;
> -                start_info.hStdInput = GetStdHandle(STD_INPUT_HANDLE);
> -                start_info.hStdOutput = start_info.hStdError = log_handle;
> -
> -                /* create an OpenVPN process for one config file */
> -                if (!CreateProcess(settings.exe_path,
> -                                   command_line,
> -                                   NULL,
> -                                   NULL,
> -                                   TRUE,
> -                                   settings.priority | CREATE_NEW_CONSOLE,
> -                                   NULL,
> -                                   settings.config_dir,
> -                                   &start_info,
> -                                   &proc_info))
> -                {
> -                    error = MsgToEventLog(M_SYSERR, TEXT("CreateProcess failed, exe='%s' cmdline='%s' dir='%s'"),
> -                                          settings.exe_path,
> -                                          command_line,
> -                                          settings.config_dir);
> -
> -                    FindClose(find_handle);
> -                    CloseHandle(log_handle);
> -                    goto finish;
> -                }
> -
> -                /* close unneeded handles */
> -                Sleep(1000); /* try to prevent race if we close logfile
> -                              * handle before child process DUPs it */
> -                if (!CloseHandle(proc_info.hProcess)
> -                    || !CloseHandle(proc_info.hThread)
> -                    || !CloseHandle(log_handle))
> -                {
> -                    error = MsgToEventLog(M_SYSERR, TEXT("CloseHandle failed"));
> -                    goto finish;
> -                }
> -            }
> -
> -            /* more files to process? */
> -            more_files = FindNextFile(find_handle, &find_obj);
> -
> -        } while (more_files);
> -
> -        FindClose(find_handle);
> -    }
> -
> -    /* we are now fully started */
> -    status.dwCurrentState = SERVICE_RUNNING;
> -    status.dwWaitHint = 0;
> -    if (!ReportStatusToSCMgr(service, &status))
> -    {
> -        MsgToEventLog(M_ERR, TEXT("ReportStatusToSCMgr SERVICE_RUNNING failed"));
> -        goto finish;
> -    }
> -
> -    /* wait for our shutdown signal */
> -    if (WaitForSingleObject(exit_event, INFINITE) != WAIT_OBJECT_0)
> -    {
> -        MsgToEventLog(M_ERR, TEXT("wait for shutdown signal failed"));
> -    }
> -
> -finish:
> -    if (exit_event)
> -    {
> -        CloseHandle(exit_event);
> -    }
> -
> -    status.dwCurrentState = SERVICE_STOPPED;
> -    status.dwWin32ExitCode = error;
> -    ReportStatusToSCMgr(service, &status);
> -}
> diff --git a/src/openvpnserv/service.c b/src/openvpnserv/service.c
> index 8101f83..9566f99 100644
> --- a/src/openvpnserv/service.c
> +++ b/src/openvpnserv/service.c
> @@ -224,21 +224,14 @@ int
>  _tmain(int argc, TCHAR *argv[])
>  {
>      /*
> -     * Automatic + Interactive service (as a SERVICE_WIN32_SHARE_PROCESS)
> +     * Interactive service (as a SERVICE_WIN32_SHARE_PROCESS)
>       * This is the default.
>       */
>      const SERVICE_TABLE_ENTRY dispatchTable_shared[] = {
> -        { automatic_service.name, ServiceStartAutomatic },
>          { interactive_service.name, ServiceStartInteractive },
>          { NULL, NULL }
>      };
>
> -    /* Automatic service only (as a SERVICE_WIN32_OWN_PROCESS) */
> -    const SERVICE_TABLE_ENTRY dispatchTable_automatic[] = {
> -        { TEXT(""), ServiceStartAutomaticOwn },
> -        { NULL, NULL }
> -    };
> -
>      /* Interactive service only (as a SERVICE_WIN32_OWN_PROCESS) */
>      const SERVICE_TABLE_ENTRY dispatchTable_interactive[] = {
>          { TEXT(""), ServiceStartInteractiveOwn },
> @@ -247,8 +240,7 @@ _tmain(int argc, TCHAR *argv[])
>
>      const SERVICE_TABLE_ENTRY *dispatchTable = dispatchTable_shared;
>
> -    openvpn_service[0] = automatic_service;
> -    openvpn_service[1] = interactive_service;
> +    openvpn_service[interactive] = interactive_service;
>
>      for (int i = 1; i < argc; i++)
>      {
> @@ -264,29 +256,33 @@ _tmain(int argc, TCHAR *argv[])
>              }
>              else if (_tcsicmp(TEXT("start"), argv[i] + 1) == 0)
>              {
> -                BOOL is_auto = argc < i + 2 || _tcsicmp(TEXT("interactive"), argv[i + 1]) != 0;
> -                return CmdStartService(is_auto ? automatic : interactive);
> +                return CmdStartService(interactive);
>              }
>              else if (argc > i + 2 && _tcsicmp(TEXT("instance"), argv[i] + 1) == 0)
>              {
> -                dispatchTable = _tcsicmp(TEXT("interactive"), argv[i + 1]) != 0 ?
> -                                dispatchTable_automatic :
> -                                dispatchTable_interactive;
> -
> -                service_instance = argv[i + 2];
> -                i += 2;
> +                if (_tcsicmp(TEXT("interactive"), argv[i+1]) == 0)
> +                {
> +                    dispatchTable = dispatchTable_interactive;
> +                    service_instance = argv[i + 2];
> +                    i += 2;
> +                }
> +                else
> +                {
> +                    MsgToEventLog(M_ERR, L"Invalid argument to -instance <%s>. Service not started.", argv[i+1]);
> +                    return 1;
> +                }
>              }
>              else
>              {
> -                _tprintf(TEXT("%s -install        to install the services\n"), APPNAME);
> -                _tprintf(TEXT("%s -start <name>   to start a service (\"automatic\" or \"interactive\")\n"), APPNAME);
> -                _tprintf(TEXT("%s -remove         to remove the services\n"), APPNAME);
> +                _tprintf(TEXT("%s -install        to install the interactive service\n"), APPNAME);
> +                _tprintf(TEXT("%s -start [name]   to start the service (name = \"interactive\" is optional)\n"), APPNAME);
> +                _tprintf(TEXT("%s -remove         to remove the service\n"), APPNAME);
>
>                  _tprintf(TEXT("\nService run-time parameters:\n"));
> -                _tprintf(TEXT("-instance <name> <id>\n")
> -                         TEXT("   Runs the service as an alternate instance. <name> can be \"automatic\" or\n")
> -                         TEXT("   \"interactive\". The service settings will be loaded from\n")
> -                         TEXT("   HKLM\\Software\\" PACKAGE_NAME "<id> registry key, and the interactive service will accept\n")
> +                _tprintf(TEXT("-instance interactive <id>\n")
> +                         TEXT("   Runs the service as an alternate instance.\n")
> +                         TEXT("   The service settings will be loaded from\n")
> +                         TEXT("   HKLM\\Software\\" PACKAGE_NAME "<id> registry key, and the service will accept\n")
>                           TEXT("   requests on \\\\.\\pipe\\" PACKAGE "<id>\\service named pipe.\n"));
>
>                  return 0;
> diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
> index f5afe2f..32a721f 100644
> --- a/src/openvpnserv/service.h
> +++ b/src/openvpnserv/service.h
> @@ -48,7 +48,6 @@
>  #define M_ERR     (MSG_FLAGS_ERROR)                    /* error */
>
>  typedef enum {
> -    automatic,
>      interactive,
>      _service_max
>  } openvpn_service_type;
> @@ -72,14 +71,9 @@ typedef struct {
>      BOOL append;
>  } settings_t;
>
> -extern openvpn_service_t automatic_service;
>  extern openvpn_service_t interactive_service;
>  extern LPCTSTR service_instance;
>
> -VOID WINAPI ServiceStartAutomaticOwn(DWORD argc, LPTSTR *argv);
> -
> -VOID WINAPI ServiceStartAutomatic(DWORD argc, LPTSTR *argv);
> -
>  VOID WINAPI ServiceStartInteractiveOwn(DWORD argc, LPTSTR *argv);
>
>  VOID WINAPI ServiceStartInteractive(DWORD argc, LPTSTR *argv);
> --
> 2.1.4
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



-- 
-Lev

