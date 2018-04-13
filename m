MIME-Version: 1.0
In-Reply-To: <20180412184845.1175-1-simon@...2293...>
References: <CAFHpkQGSx5hjLhGYgUyqYCKZJ9MMWL1sYT2cSd5y5wy+=j6iAw@...278...>
 <20180412184845.1175-1-simon@...2293...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 13 Apr 2018 01:05:31 -0400
Message-ID: <CAKuzo_iSR8Z52TWyMC1nXFZmU=UbwKHsf_7QnHG+YU8qU2Y2Fg@...278...>
Content-Type: multipart/alternative; boundary="0000000000007ec7120569b3d328"
Subject: Re: [Openvpn-devel] [PATCH] Add Interactive Service developer
 documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000007ec7120569b3d328
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Apr 12, 2018 at 2:48 PM, Simon Rozman <simon@...2293...> wrote:

Moving up the most important part:

Hi,
> I'm back. :)
>

Welcome back!


> I took the short Interactive Service introduction found at
> https://community.openvpn.net/openvpn/wiki/OpenVPNInteractiveService and
> extended it with my experience while developing the eduVPN client.
> This document is not up to the RFC standards nor it intends to be.
> It's written using reStructuredText markup as suggested by Iliya, but
> keeping
> the filename and ".txt" extension as suggested by Samuli.
> I suggest replacing the
> https://community.openvpn.net/openvpn/wiki/OpenVPNInteractiveService wiki
> page


+1 to that and to keep it up to date.


> with this document analogous to the Management Interface Notes document
> published online at
> https://openvpn.net/index.php/open-source/documentation/misc
> ellaneous/79-management-interface.html.


This one too occasionally needs to be kept in sync with the source

Your comments are welcome.


Thanks for writing this up. Some minor comments below:

The OpenVPN Interactive Service documentation from
> https://community.openvpn.net/openvpn/wiki/OpenVPNInteractiveService was
> upgraded with a description of the client-service communication flow,
> service registry configuration, and non-default instance installation.
> ---
>  doc/interactive-service-notes.txt | 316 ++++++++++++++++++++++++++++++
> ++++++++
>  1 file changed, 316 insertions(+)
>  create mode 100644 doc/interactive-service-notes.txt
>
> diff --git a/doc/interactive-service-notes.txt
> b/doc/interactive-service-notes.txt
> new file mode 100644
> index 00000000..9b3b8f6c
> --- /dev/null
> +++ b/doc/interactive-service-notes.txt
> @@ -0,0 +1,316 @@
> +=================================
> +OpenVPN Interactive Service Notes
> +=================================
> +
> +
> +Introduction
> +============
> +
> +OpenVPN Interactive Service, also known as "iservice" or
> +"OpenVPNServiceInteractive", is a Windows system service which allows
> +unprivileged users to do certain privileged operations required by
> OpenVPN, such
> +as adding routes. This removes the need to always run OpenVPN as
> administrator,
> +which was the case for a long time, and continues to be the case for
> OpenVPN
> +2.3.x.
> +
> +The 2.4.x release and git "master" versions of OpenVPN contain the
> Interactive
> +Service code and OpenVPN-GUI is setup to use it by default. Starting from
> +version 2.4.0, OpenVPN-GUI is expected to be started as user (do not
> right-click
> +and "run as administrator" or do not set the shortcut to run as
> administrator).
> +This ensures that OpenVPN and the GUI run with limited privileges.
> +
> +
> +How It Works
> +============
> +
> +Here is a brief explanation of how the Interactive Service works, based on
> +`Gert's email`_ to openvpn-devel mailing list. The example user, *joe*,
> is not
> +an administrator, and does not have any other extra privileges.
> +
> +- OpenVPN-GUI runs as a *joe*
> +- Interactive Service runs as a local Windows service with maximum
> privileges
> +- OpenVPN-GUI connects to the Interactive Service and asks it "run
> openvpn.exe
> +  with the following arguments, using the *joe*'s credentials" - Windows
> can do
> +  this - pass credentials across a pipe, which you can't fake
> +- Interactive Service forks openvpn.exe, and runs this as the user *joe*,
> and
> +  keeps a "service pipe" between Interactive Service and openvpn.exe
> +- If openvpn.exe wants to do ipconfig/route/dns stuff, it sends these as
> +  requests over the service pipe to the Interactive Service, which will
> then
> +  execute them (and clean up should openvpn.exe crash)
> +- ``--up`` scripts are run by openvpn.exe itself, which is already
> running as
> +  *joe*, all privileges are nicely in place
> +- Scripts run by the GUI will run as user *joe*, so that automated tasks
> like
> +  mapping of drives work as expected

+
> +This also avoids the use of scripts for privilege escalation to admin (as
> was
> +possible by running an ``--up`` script from openvpn.exe which is run as
> admin).

+
>

Considering the more formal style used below, the above paragraph could be
rewritten too. IMO, its not necessary to preserve the "original"
description of
"How it works". Just saying..


> +
> +Client-Service Communication
> +============================
> +
> +Connecting
> +----------
> +
> +The client (OpenVPN GUI) and the Interactive Service communicate using a
> named
> +message pipe. By default, the service provides the
> ``\\.\pipe\openvpn\service``
> +named pipe.
> +
> +The client connects to the pipe for read/write and sets the pipe state to
> the
>

state to the --> state to


> +``PIPE_READMODE_MESSAGE``::
> +
> +   HANDLE pipe = CreateFile(_T("\\\\.\\pipe\\openvpn\\service"),
> +       GENERIC_READ | GENERIC_WRITE,
> +       0,
> +       NULL,
> +       OPEN_EXISTING,
> +       FILE_FLAG_OVERLAPPED,
> +       NULL);
> +
> +   if (pipe == INVALID_HANDLE_VALUE)
> +   {
> +       // Error
> +   }
> +
> +   DWORD dwMode = PIPE_READMODE_MESSAGE;
> +   if (!SetNamedPipeHandleState(pipe, &dwMode, NULL, NULL)
> +   {
> +       // Error
> +   }
> +
> +
> +openvpn.exe Startup
> +-------------------
> +
> +After the client is connected to the service, the client must send a
> startup
> +message to have the service start the openvpn.exe process. The startup
> message
> +is comprised of three UTF-16 strings delimited by U0000 zero characters::
> +
> +   startupmsg     = workingdir WZERO openvpnoptions WZERO stdin WZERO
> +
> +   workingdir     = WSTRING
> +   openvpnoptions = WSTRING
> +   stdin          = WSTRING
> +
> +   WSTRING        = *WCHAR
> +   WCHAR          = %x0001-FFFF
> +   WZERO          = %x0000
> +
> +``workingdir``
> +   Represents the folder openvpn.exe process should be started in.
> +
> +``openvpnoptions``
> +   String contains ``--config`` and other OpenVPN command line options,
> without
> +   the ``argv[0]`` executable name ("openvpn" or "openvpn.exe"). When
> there is
> +   only one option specified, the ``--config`` option is assumed and the
> option
> +   is the configuration filename.
> +
> +   Please, note that the interactive service validates the options (e.g.
> OpenVPN
>

Please, note --> Please note  or just "Note" considering the overall style

+   config file must reside in one of the approved folders, or the invoking
> user


Actually only one approved folder (and its subfolders) is supported. That
is, the
one defined by the global_config_dir. For all other folders the user must
be
authorized.

Even when the config file is in the approved folder, additional options
added to
the command line are restricted to a limited set unless the user is
authorized.


> +   must be a member of local Administrators group, or a member of the

+   "OpenVPN Administrators" group).
>

More precisely, that would be the group pointed to by the registry key
HKLM\Software\OpenVPN\ovpn_admin_group which defaults to
"OpenVPN Administrators".


> +
> +``stdin``
> +   The content of the ``stdin`` string is sent to the openvpn.exe process
> to its
> +   stdin stream after it starts.
> +
> +   When a ``--management ... stdin`` option is present, the openvpn.exe
> process
> +   will prompt for the management interface password on start. In this
> case, the
> +   ``stdin`` must contain the password appended with an LF (U000A) to
> simulate
> +   the [Enter] key after the password is "typed" in.
> +
> +   The openvpn.exe's stdout is redirected to ``NUL``. Should the client
> require
> +   openvpn.exe's stdout, one should specify ``--log`` option.
> +
> +The message must be written in a single ``WriteFile()`` call.

+Example::
> +
> +   // Prepare the message.
> +   size_t msg_len =
> +       wcslen(workingdir) + 1 +
> +       wcslen(options   ) + 1 +
> +       wcslen(manage_pwd) + 1;
> +   wchar_t *msg_data = (wchar_t*)malloc(msg_len*sizeof(wchar_t));
> +   _snwprintf(msg_data, msg_len, L"%s%c%s%c%s",
> +       workingdir, L'\0',
> +       options, L'\0',
> +       manage_pwd)
> +
> +   // Send the message.
> +   DWORD dwBytesWritten;
> +   if (!WriteFile(pipe,
> +       msg_data,
> +       msg_len*sizeof(wchar_t),
> +       &dwBytesWritten,
> +       NULL))
> +   {
> +       // Error
> +   }
> +
> +   // Sanitize memory, since the stdin component of the message
> +   // contains the management interface password.
> +   SecureZeroMemory(msg_data, msg_len*sizeof(wchar_t));
> +   free(msg_data);
> +
> +
> +openvpn.exe Process ID
> +----------------------
> +
> +After receiving the startup message, the Interactive Service validates
> the user
> +and specified options before launching the openvpn.exe process.
> +
> +The Interactive Service replies with a process ID message. The process ID
> +message is comprised of three UTF-16 strings delimited by LFs (U000A)::
> +
> +   pidmsg  = L"0x00000000" WLF L"0x" pid WLF L"Process ID"
> +
> +   pid     = 8*8WHEXDIG
> +
> +   WHEXDIG = WDIGIT / L"A" / L"B" / L"C" / L"D" / L"E" / L"F"
> +   WDIGIT  = %x0030-0039
> +   WLF     = %x000a
> +
> +``pid``
> +   An UTF-16 eight-character hexadecimal process ID of the openvpn.exe
> process
>

A UTF-16


> +   the Interactive Service launched on client's behalf.
> +
> +
> +openvpn.exe Termination
> +-----------------------
> +
> +The pipe between the client and the service is kept open until the
> openvpn.exe
> +process terminates.
> +
> +Should the openvpn.exe process terminate with an error, the Interactive
> Service
> +sends an error message to the client before disconnecting the pipe.
>

May be also mention that the service never terminates openvpn.exe process
-- not even
when it is stopped or restarted. So its up to the client to monitor the
process
and terminate it.


> +
> +
> +Error Messages
> +--------------
> +
> +In case of an error, the Interactive Service sends an error message to the
> +client. Error messages are comprised of three UTF-16 strings delimited by
> LFs
> +(U000A)::
> +
> +   errmsg = L"0x" errnum WLF func WLF msg
> +
> +   errnum = 8*8WHEXDIG
> +   func   = WSTRING
> +   msg    = WSTRING
> +
> +``errnum``
> +
> +   An UTF-16 eight-character hexadecimal error code. Typically, it is one
> of the
>

An --> A


> +   Win32 error codes returned by ``GetLastError()``.
> +
> +   However, it can be one of the Interactive Service specific error codes:
> +
> +   ===================== ==========
> +   Error                 Code
> +   ===================== ==========
> +   ERROR_OPENVPN_STARTUP 0x20000000
> +   ERROR_STARTUP_DATA    0x20000001
> +   ERROR_MESSAGE_DATA    0x20000002
> +   ERROR_MESSAGE_TYPE    0x20000003
> +   ===================== ==========
> +
> +``func``
> +   The name of the function call that failed or an error description.
> +
> +``msg``
> +  The error description returned by a
> +  ``FormatMessageW(FORMAT_MESSAGE_FROM_SYSTEM, 0, errnum, ...)`` call.
> +
> +
> +Interactive Service Configuration
> +=================================
> +
> +The Interactive Service settings are read from the
> +``HKEY_LOCAL_MACHINE\SOFTWARE\OpenVPN`` registry key by default.
> +
> +All the following registry values are of the ``REG_SZ`` type:
> +
> +*Default*
> +   Installation folder (required)
>

install_dir used below is undefined. Define it here?


> +
> +``exe_path``
> +   The absolute path to the openvpn.exe binary; defaults to
> +   ``install_dir "\bin\openvpn.exe"``.
> +
> +``config_dir``
> +   The path to the configuration folder; defaults to ``install_dir
> "\config"``.
> +
> +``priority``
> +   openvpn.exe process priority; one of the following strings:
> +
> +   - ``"IDLE_PRIORITY_CLASS"``
> +   - ``"BELOW_NORMAL_PRIORITY_CLASS"``
> +   - ``"NORMAL_PRIORITY_CLASS"`` (default)
> +   - ``"ABOVE_NORMAL_PRIORITY_CLASS"``
> +   - ``"HIGH_PRIORITY_CLASS"``
> +
> +``ovpn_admin_group``
> +   The name of the local group, whose members are authorized to use the
> +   Interactive Service unrestricted; defaults to ``"OpenVPN
> Administrators"``
> +
> +
> +Multiple Interactive Service Instances
> +======================================
> +
> +OpenVPN 2.4.5 extended the Interactive Service to support multiple
> side-by-side
> +running instances. This allows clients to use different Interactive
> Service
> +versions with different settings and/or openvpn.exe binary version on the
> same
> +computer.
> +
> +OpenVPN installs the default Interactive Service instance only. The
> default
> +instance is used by OpenVPN GUI client and also provides backward
> compatibility.
> +
> +
> +Installing a Non-default Interactive Service Instance
> +-----------------------------------------------------
> +
> +1. Choose a unique instance name. For example: "$v2.5-test". The instance
> name
> +   is appended to the default registry path and service name. We choose
> to start
> +   it with a dollar "$" sign analogous to Microsoft SQL Server instance
> naming
> +   scheme. However, this is not imperative.

+
> +   Appending the name to the registry path and service name also implies
> the
> +   name cannot contain characters not allowed in Windows paths: "<", ">",
> double
> +   quote etc.
> +
> +2. Create an ``HKEY_LOCAL_MACHINE\SOFTWARE\OpenVPN$v2.5-test`` registry
> key and
> +   configure the Interactive Service instance configuration appropriately.
> +
> +   This allows using slightly or completely different settings from the
> default
> +   instance.
> +
> +   See the `Interactive Service Configuration`_ chapter for the list of
> registry
>

chapter --> section ? And is that "_" a part of markup or a stale character?


> +   values.
> +
> +3. Create and start the instance's Windows service from an elevated
> command
> +   prompt::
> +
> +      sc create "OpenVPNServiceInteractive$v2.5-test" \
> +         start= auto \
> +         binPath= "<path to openvpnserv.exe> -instance interactive
> $v2.5-test" \
> +         depend= tap0901/Dhcp \
> +         DisplayName= "OpenVPN Interactive Service (v2.5-test)"
> +
> +      sc start "OpenVPNServiceInteractive$v2.5-test"
> +
> +   This allows using the same or a different version of openvpnserv.exe
> than the
> +   default instance.
> +
> +   Please, mind the spacing around "=" character in ``sc`` command line
> options.
>

Please, mind the spacing around "=" --> Notice the space after "="

+
> +4. Set your OpenVPN client to connect to the
> +   ``\\.\pipe\openvpn$v2.5-test\service``.
> +
> +   This allows the client to select different installed Interactive
> Service
>

different --> a different


> +   instance at run-time, thus allowing different OpenVPN settings and
> versions.
> +
> +   At the time writing, the OpenVPN GUI client supports connecting to the
> +   default Interactive Service instance only.
> +
> +.. _`Gert's email`: https://www.mail-archive.com/o
> penvpn-devel@lists.sourceforge.net/msg00097.html
> --
> 2.15.1 (Apple Git-101)
>
>
Do you also plan to document the service <--> openvpn.exe communication?
Or is that beyond the scope of this file? Anyway, could be a separate patch
:)

Thanks,

Selva

--0000000000007ec7120569b3d328
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br><div class=3D"gmail_extra"><div class=3D"gmail=
_quote">On Thu, Apr 12, 2018 at 2:48 PM, Simon Rozman <span dir=3D"ltr">&lt=
;<a href=3D"mailto:simon@...2293..." target=3D"_blank">simon@...2293...</a>=
&gt;</span> wrote:</div><div class=3D"gmail_quote"><br></div><div class=3D"=
gmail_quote">Moving up the most important part:</div><div class=3D"gmail_qu=
ote"><div class=3D"gmail_quote"><br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Hi,<br>I&#39;m back. :)<br></blockquote><div><br></div><di=
v>Welcome back!</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">I took the short Interactive Service introduction found at<br>=
<a href=3D"https://community.openvpn.net/openvpn/wiki/OpenVPNInteractiveSer=
vice" target=3D"_blank">https://community.openvpn.net/<wbr>openvpn/wiki/Ope=
nVPNInteractiv<wbr>eService</a> and<br>extended it with my experience while=
 developing the eduVPN client.<br>This document is not up to the RFC standa=
rds nor it intends to be.<br>It&#39;s written using reStructuredText markup=
 as suggested by Iliya, but keeping<br>the filename and &quot;.txt&quot; ex=
tension as suggested by Samuli.<br>I suggest replacing the<br><a href=3D"ht=
tps://community.openvpn.net/openvpn/wiki/OpenVPNInteractiveService" target=
=3D"_blank">https://community.openvpn.net/<wbr>openvpn/wiki/OpenVPNInteract=
iv<wbr>eService</a> wiki page</blockquote><div class=3D"gmail_quote"><br></=
div><div class=3D"gmail_quote">+1 to that and to keep it up to date.</div><=
div class=3D"gmail_quote">=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">with this document analogous to the Management Interface Notes=
 document<br>published online at<br><a href=3D"https://openvpn.net/index.ph=
p/open-source/documentation/miscellaneous/79-management-interface.html" tar=
get=3D"_blank">https://openvpn.net/index.php/<wbr>open-source/documentation=
/misc<wbr>ellaneous/79-management-interf<wbr>ace.html</a>.</blockquote><div=
 class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">This one too oc=
casionally needs to be kept in sync with the source</div><div class=3D"gmai=
l_quote"><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Your c=
omments are welcome.</blockquote><div class=3D"gmail_quote"><br></div><div =
class=3D"gmail_quote">Thanks for writing this up. Some minor comments below=
:</div></div><div class=3D"gmail_quote"><br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">The OpenVPN Interactive Service documentation from<br>
<a href=3D"https://community.openvpn.net/openvpn/wiki/OpenVPNInteractiveSer=
vice" rel=3D"noreferrer" target=3D"_blank">https://community.openvpn.net/<w=
br>openvpn/wiki/OpenVPNInteractiv<wbr>eService</a> was<br>
upgraded with a description of the client-service communication flow,<br>
service registry configuration, and non-default instance installation.<br>
---<br>
=C2=A0doc/interactive-service-notes<wbr>.txt | 316 ++++++++++++++++++++++++=
++++++<wbr>++++++++<br>
=C2=A01 file changed, 316 insertions(+)<br>
=C2=A0create mode 100644 doc/interactive-service-notes.<wbr>txt<br>
<br>
diff --git a/doc/interactive-service-note<wbr>s.txt b/doc/interactive-servi=
ce-note<wbr>s.txt<br>
new file mode 100644<br>
index 00000000..9b3b8f6c<br>
--- /dev/null<br>
+++ b/doc/interactive-service-note<wbr>s.txt<br>
@@ -0,0 +1,316 @@<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<wbr>=3D=3D=3D=3D<br>
+OpenVPN Interactive Service Notes<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<wbr>=3D=3D=3D=3D<br>
+<br>
+<br>
+Introduction<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
+<br>
+OpenVPN Interactive Service, also known as &quot;iservice&quot; or<br>
+&quot;OpenVPNServiceInteractive&quot;, is a Windows system service which a=
llows<br>
+unprivileged users to do certain privileged operations required by OpenVPN=
, such<br>
+as adding routes. This removes the need to always run OpenVPN as administr=
ator,<br>
+which was the case for a long time, and continues to be the case for OpenV=
PN<br>
+2.3.x.<br>
+<br>
+The 2.4.x release and git &quot;master&quot; versions of OpenVPN contain t=
he Interactive<br>
+Service code and OpenVPN-GUI is setup to use it by default. Starting from<=
br>
+version 2.4.0, OpenVPN-GUI is expected to be started as user (do not right=
-click<br>
+and &quot;run as administrator&quot; or do not set the shortcut to run as =
administrator).<br>
+This ensures that OpenVPN and the GUI run with limited privileges.<br>
+<br>
+<br>
+How It Works<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
+<br>
+Here is a brief explanation of how the Interactive Service works, based on=
<br>
+`Gert&#39;s email`_ to openvpn-devel mailing list. The example user, *joe*=
, is not<br>
+an administrator, and does not have any other extra privileges.<br>
+<br>
+- OpenVPN-GUI runs as a *joe*<br>
+- Interactive Service runs as a local Windows service with maximum privile=
ges<br>
+- OpenVPN-GUI connects to the Interactive Service and asks it &quot;run op=
envpn.exe<br>
+=C2=A0 with the following arguments, using the *joe*&#39;s credentials&quo=
t; - Windows can do<br>
+=C2=A0 this - pass credentials across a pipe, which you can&#39;t fake<br>
+- Interactive Service forks openvpn.exe, and runs this as the user *joe*, =
and<br>
+=C2=A0 keeps a &quot;service pipe&quot; between Interactive Service and op=
envpn.exe<br>
+- If openvpn.exe wants to do ipconfig/route/dns stuff, it sends these as<b=
r>
+=C2=A0 requests over the service pipe to the Interactive Service, which wi=
ll then<br>
+=C2=A0 execute them (and clean up should openvpn.exe crash)<br>
+- ``--up`` scripts are run by openvpn.exe itself, which is already running=
 as<br>
+=C2=A0 *joe*, all privileges are nicely in place<br>
+- Scripts run by the GUI will run as user *joe*, so that automated tasks l=
ike<br>
+=C2=A0 mapping of drives work as expected</blockquote><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
+<br>
+This also avoids the use of scripts for privilege escalation to admin (as =
was<br>
+possible by running an ``--up`` script from openvpn.exe which is run as ad=
min).</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">+<br></=
blockquote><div><br></div><div>Considering the more formal style used below=
, the above paragraph could be</div><div>rewritten too. IMO, its not necess=
ary to preserve the &quot;original&quot; description of</div><div>&quot;How=
 it works&quot;. Just saying..</div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
+<br>
+Client-Service Communication<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>
+<br>
+Connecting<br>
+----------<br>
+<br>
+The client (OpenVPN GUI) and the Interactive Service communicate using a n=
amed<br>
+message pipe. By default, the service provides the ``\\.\pipe\openvpn\serv=
ice``<br>
+named pipe.<br>
+<br>
+The client connects to the pipe for read/write and sets the pipe state to =
the<br></blockquote><div><br></div><div>state to the --&gt; state to</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+``PIPE_READMODE_MESSAGE``::<br>
+<br>
+=C2=A0 =C2=A0HANDLE pipe =3D CreateFile(_T(&quot;\\\\.\\pipe\\op<wbr>envpn=
\\service&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0GENERIC_READ | GENERIC_WRITE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A00,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0OPEN_EXISTING,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0FILE_FLAG_OVERLAPPED,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0NULL);<br>
+<br>
+=C2=A0 =C2=A0if (pipe =3D=3D INVALID_HANDLE_VALUE)<br>
+=C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0// Error<br>
+=C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0DWORD dwMode =3D PIPE_READMODE_MESSAGE;<br>
+=C2=A0 =C2=A0if (!SetNamedPipeHandleState(pipe<wbr>, &amp;dwMode, NULL, NU=
LL)<br>
+=C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0// Error<br>
+=C2=A0 =C2=A0}<br>
+<br>
+<br>
+openvpn.exe Startup<br>
+-------------------<br>
+<br>
+After the client is connected to the service, the client must send a start=
up<br>
+message to have the service start the openvpn.exe process. The startup mes=
sage<br>
+is comprised of three UTF-16 strings delimited by U0000 zero characters::<=
br>
+<br>
+=C2=A0 =C2=A0startupmsg=C2=A0 =C2=A0 =C2=A0=3D workingdir WZERO openvpnopt=
ions WZERO stdin WZERO<br>
+<br>
+=C2=A0 =C2=A0workingdir=C2=A0 =C2=A0 =C2=A0=3D WSTRING<br>
+=C2=A0 =C2=A0openvpnoptions =3D WSTRING<br>
+=C2=A0 =C2=A0stdin=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D WSTRING<br>
+<br>
+=C2=A0 =C2=A0WSTRING=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D *WCHAR<br>
+=C2=A0 =C2=A0WCHAR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D %x0001-FFFF<br>
+=C2=A0 =C2=A0WZERO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D %x0000<br>
+<br>
+``workingdir``<br>
+=C2=A0 =C2=A0Represents the folder openvpn.exe process should be started i=
n.<br>
+<br>
+``openvpnoptions``<br>
+=C2=A0 =C2=A0String contains ``--config`` and other OpenVPN command line o=
ptions, without<br>
+=C2=A0 =C2=A0the ``argv[0]`` executable name (&quot;openvpn&quot; or &quot=
;openvpn.exe&quot;). When there is<br>
+=C2=A0 =C2=A0only one option specified, the ``--config`` option is assumed=
 and the option<br>
+=C2=A0 =C2=A0is the configuration filename.<br>
+<br>
+=C2=A0 =C2=A0Please, note that the interactive service validates the optio=
ns (e.g. OpenVPN<br></blockquote><div><br></div><div>Please, note --&gt; Pl=
ease note =C2=A0or just &quot;Note&quot; considering the overall style</div=
><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0config file must reside in one of the approved folders, or th=
e invoking user</blockquote><div><br></div><div>Actually only one approved =
folder (and its subfolders) is supported. That is, the</div><div>one define=
d by the global_config_dir. For all other folders the user must be=C2=A0</d=
iv><div>authorized.</div><div><br></div><div><div style=3D"color:rgb(34,34,=
34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-var=
iant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spaci=
ng:normal;text-align:start;text-indent:0px;text-transform:none;white-space:=
normal;word-spacing:0px;background-color:rgb(255,255,255)">Even when the co=
nfig file is in the approved folder, additional options added to</div><div =
style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;f=
ont-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fon=
t-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tr=
ansform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,2=
55,255)">the command line are restricted to a limited set unless the user i=
s authorized.</div></div><div>=C2=A0=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
+=C2=A0 =C2=A0must be a member of local Administrators group, or a member o=
f the=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">+=
=C2=A0 =C2=A0&quot;OpenVPN Administrators&quot; group).<br></blockquote><di=
v><br></div><div><div>More precisely, that would be the group pointed to by=
 the registry key=C2=A0</div><div>HKLM\Software\OpenVPN\ovpn_adm<wbr>in_gro=
up which defaults to</div><div>&quot;OpenVPN Administrators&quot;.</div></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+``stdin``<br>
+=C2=A0 =C2=A0The content of the ``stdin`` string is sent to the openvpn.ex=
e process to its<br>
+=C2=A0 =C2=A0stdin stream after it starts.<br>
+<br>
+=C2=A0 =C2=A0When a ``--management ... stdin`` option is present, the open=
vpn.exe process<br>
+=C2=A0 =C2=A0will prompt for the management interface password on start. I=
n this case, the<br>
+=C2=A0 =C2=A0``stdin`` must contain the password appended with an LF (U000=
A) to simulate<br>
+=C2=A0 =C2=A0the [Enter] key after the password is &quot;typed&quot; in.<b=
r>
+<br>
+=C2=A0 =C2=A0The openvpn.exe&#39;s stdout is redirected to ``NUL``. Should=
 the client require<br>
+=C2=A0 =C2=A0openvpn.exe&#39;s stdout, one should specify ``--log`` option=
.<br>
+<br>
+The message must be written in a single ``WriteFile()`` call.</blockquote>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+Example::<br>
+<br>
+=C2=A0 =C2=A0// Prepare the message.<br>
+=C2=A0 =C2=A0size_t msg_len =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wcslen(workingdir) + 1 +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wcslen(options=C2=A0 =C2=A0) + 1 +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wcslen(manage_pwd) + 1;<br>
+=C2=A0 =C2=A0wchar_t *msg_data =3D (wchar_t*)malloc(msg_len*sizeo<wbr>f(wc=
har_t));<br>
+=C2=A0 =C2=A0_snwprintf(msg_data, msg_len, L&quot;%s%c%s%c%s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0workingdir, L&#39;\0&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0options, L&#39;\0&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0manage_pwd)<br>
+<br>
+=C2=A0 =C2=A0// Send the message.<br>
+=C2=A0 =C2=A0DWORD dwBytesWritten;<br>
+=C2=A0 =C2=A0if (!WriteFile(pipe,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0msg_data,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0msg_len*sizeof(wchar_t),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;dwBytesWritten,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0NULL))<br>
+=C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0// Error<br>
+=C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0// Sanitize memory, since the stdin component of the message<=
br>
+=C2=A0 =C2=A0// contains the management interface password.<br>
+=C2=A0 =C2=A0SecureZeroMemory(msg_data, msg_len*sizeof(wchar_t));<br>
+=C2=A0 =C2=A0free(msg_data);<br>
+<br>
+<br>
+openvpn.exe Process ID<br>
+----------------------<br>
+<br>
+After receiving the startup message, the Interactive Service validates the=
 user<br>
+and specified options before launching the openvpn.exe process.<br>
+<br>
+The Interactive Service replies with a process ID message. The process ID<=
br>
+message is comprised of three UTF-16 strings delimited by LFs (U000A)::<br>
+<br>
+=C2=A0 =C2=A0pidmsg=C2=A0 =3D L&quot;0x00000000&quot; WLF L&quot;0x&quot; =
pid WLF L&quot;Process ID&quot;<br>
+<br>
+=C2=A0 =C2=A0pid=C2=A0 =C2=A0 =C2=A0=3D 8*8WHEXDIG<br>
+<br>
+=C2=A0 =C2=A0WHEXDIG =3D WDIGIT / L&quot;A&quot; / L&quot;B&quot; / L&quot=
;C&quot; / L&quot;D&quot; / L&quot;E&quot; / L&quot;F&quot;<br>
+=C2=A0 =C2=A0WDIGIT=C2=A0 =3D %x0030-0039<br>
+=C2=A0 =C2=A0WLF=C2=A0 =C2=A0 =C2=A0=3D %x000a<br>
+<br>
+``pid``<br>
+=C2=A0 =C2=A0An UTF-16 eight-character hexadecimal process ID of the openv=
pn.exe process<br>
</blockquote><div><br></div><div>A UTF-16</div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">+=C2=A0 =C2=A0the Interactive Servic=
e launched on client&#39;s behalf.<br>
+<br>
+<br>
+openvpn.exe Termination<br>
+-----------------------<br>
+<br>
+The pipe between the client and the service is kept open until the openvpn=
.exe<br>
+process terminates.<br>
+<br>
+Should the openvpn.exe process terminate with an error, the Interactive Se=
rvice<br>
+sends an error message to the client before disconnecting the pipe.<br>
</blockquote><div><br></div><div>May be also mention that the service never=
 terminates openvpn.exe process -- not even</div><div>when it is stopped or=
 restarted. So its up to the client to monitor the process</div><div>and te=
rminate it.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">+<br>
+<br>
+Error Messages<br>
+--------------<br>
+<br>
+In case of an error, the Interactive Service sends an error message to the=
<br>
+client. Error messages are comprised of three UTF-16 strings delimited by =
LFs<br>
+(U000A)::<br>
+<br>
+=C2=A0 =C2=A0errmsg =3D L&quot;0x&quot; errnum WLF func WLF msg<br>
+<br>
+=C2=A0 =C2=A0errnum =3D 8*8WHEXDIG<br>
+=C2=A0 =C2=A0func=C2=A0 =C2=A0=3D WSTRING<br>
+=C2=A0 =C2=A0msg=C2=A0 =C2=A0 =3D WSTRING<br>
+<br>
+``errnum``<br>
+<br>
+=C2=A0 =C2=A0An UTF-16 eight-character hexadecimal error code. Typically, =
it is one of the<br></blockquote><div><br></div><div>An --&gt; A=C2=A0</div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0Win32 error codes returned by ``GetLastError()``.<br>
+<br>
+=C2=A0 =C2=A0However, it can be one of the Interactive Service specific er=
ror codes:<br>
+<br>
+=C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
+=C2=A0 =C2=A0Error=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0Code<br>
+=C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
+=C2=A0 =C2=A0ERROR_OPENVPN_STARTUP 0x20000000<br>
+=C2=A0 =C2=A0ERROR_STARTUP_DATA=C2=A0 =C2=A0 0x20000001<br>
+=C2=A0 =C2=A0ERROR_MESSAGE_DATA=C2=A0 =C2=A0 0x20000002<br>
+=C2=A0 =C2=A0ERROR_MESSAGE_TYPE=C2=A0 =C2=A0 0x20000003<br>
+=C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
+<br>
+``func``<br>
+=C2=A0 =C2=A0The name of the function call that failed or an error descrip=
tion.<br>
+<br>
+``msg``<br>
+=C2=A0 The error description returned by a<br>
+=C2=A0 ``FormatMessageW(FORMAT_MESSAG<wbr>E_FROM_SYSTEM, 0, errnum, ...)``=
 call.<br>
+<br>
+<br>
+Interactive Service Configuration<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<wbr>=3D=3D=3D=3D<br>
+<br>
+The Interactive Service settings are read from the<br>
+``HKEY_LOCAL_MACHINE\SOFTWARE<wbr>\OpenVPN`` registry key by default.<br>
+<br>
+All the following registry values are of the ``REG_SZ`` type:<br>
+<br>
+*Default*<br>
+=C2=A0 =C2=A0Installation folder (required)<br></blockquote><div><br></div=
><div>install_dir used below is undefined. Define it here?</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+``exe_path``<br>
+=C2=A0 =C2=A0The absolute path to the openvpn.exe binary; defaults to<br>
+=C2=A0 =C2=A0``install_dir &quot;\bin\openvpn.exe&quot;``.<br>
+<br>
+``config_dir``<br>
+=C2=A0 =C2=A0The path to the configuration folder; defaults to ``install_d=
ir &quot;\config&quot;``.<br>
+<br>
+``priority``<br>
+=C2=A0 =C2=A0openvpn.exe process priority; one of the following strings:<b=
r>
+<br>
+=C2=A0 =C2=A0- ``&quot;IDLE_PRIORITY_CLASS&quot;``<br>
+=C2=A0 =C2=A0- ``&quot;BELOW_NORMAL_PRIORITY_CLASS<wbr>&quot;``<br>
+=C2=A0 =C2=A0- ``&quot;NORMAL_PRIORITY_CLASS&quot;`` (default)<br>
+=C2=A0 =C2=A0- ``&quot;ABOVE_NORMAL_PRIORITY_CLASS<wbr>&quot;``<br>
+=C2=A0 =C2=A0- ``&quot;HIGH_PRIORITY_CLASS&quot;``<br>
+<br>
+``ovpn_admin_group``<br>
+=C2=A0 =C2=A0The name of the local group, whose members are authorized to =
use the<br>
+=C2=A0 =C2=A0Interactive Service unrestricted; defaults to ``&quot;OpenVPN=
 Administrators&quot;``<br>
+<br>
+<br>
+Multiple Interactive Service Instances<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<wbr>=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
+<br>
+OpenVPN 2.4.5 extended the Interactive Service to support multiple side-by=
-side<br>
+running instances. This allows clients to use different Interactive Servic=
e<br>
+versions with different settings and/or openvpn.exe binary version on the =
same<br>
+computer.<br>
+<br>
+OpenVPN installs the default Interactive Service instance only. The defaul=
t<br>
+instance is used by OpenVPN GUI client and also provides backward compatib=
ility.<br>
+<br>
+<br>
+Installing a Non-default Interactive Service Instance<br>
+-----------------------------<wbr>------------------------<br>
+<br>
+1. Choose a unique instance name. For example: &quot;$v2.5-test&quot;. The=
 instance name<br>
+=C2=A0 =C2=A0is appended to the default registry path and service name. We=
 choose to start<br>
+=C2=A0 =C2=A0it with a dollar &quot;$&quot; sign analogous to Microsoft SQ=
L Server instance naming<br>
+=C2=A0 =C2=A0scheme. However, this is not imperative.=C2=A0</blockquote><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0Appending the name to the registry path and service name also=
 implies the<br>
+=C2=A0 =C2=A0name cannot contain characters not allowed in Windows paths: =
&quot;&lt;&quot;, &quot;&gt;&quot;, double<br>
+=C2=A0 =C2=A0quote etc.<br>
+<br>
+2. Create an ``HKEY_LOCAL_MACHINE\SOFTWARE\<wbr>OpenVPN$v2.5-test`` regist=
ry key and<br>
+=C2=A0 =C2=A0configure the Interactive Service instance configuration appr=
opriately.<br>
+<br>
+=C2=A0 =C2=A0This allows using slightly or completely different settings f=
rom the default<br>
+=C2=A0 =C2=A0instance.<br>
+<br>
+=C2=A0 =C2=A0See the `Interactive Service Configuration`_ chapter for the =
list of registry<br></blockquote><div><br></div><div>chapter --&gt; section=
 ? And is that &quot;_&quot; a part of markup or a stale character?</div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0values.<br>
+<br>
+3. Create and start the instance&#39;s Windows service from an elevated co=
mmand<br>
+=C2=A0 =C2=A0prompt::<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 sc create &quot;OpenVPNServiceInteractive$v2.<wbr>5-t=
est&quot; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0start=3D auto \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0binPath=3D &quot;&lt;path to openvpnserv=
.exe&gt; -instance interactive $v2.5-test&quot; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0depend=3D tap0901/Dhcp \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DisplayName=3D &quot;OpenVPN Interactive=
 Service (v2.5-test)&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 sc start &quot;OpenVPNServiceInteractive$v2.<wbr>5-te=
st&quot;<br>
+<br>
+=C2=A0 =C2=A0This allows using the same or a different version of openvpns=
erv.exe than the<br>
+=C2=A0 =C2=A0default instance.<br>
+<br>
+=C2=A0 =C2=A0Please, mind the spacing around &quot;=3D&quot; character in =
``sc`` command line options.<br></blockquote><div><br></div><div>Please, mi=
nd the spacing around &quot;=3D&quot; --&gt; Notice the space after &quot;=
=3D&quot;=C2=A0</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+<br>
+4. Set your OpenVPN client to connect to the<br>
+=C2=A0 =C2=A0``\\.\pipe\openvpn$v2.5-test\<wbr>service``.<br>
+<br>
+=C2=A0 =C2=A0This allows the client to select different installed Interact=
ive Service<br></blockquote><div><br></div><div>different --&gt; a differen=
t</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0instance at run-time, thus allowing different OpenVPN setting=
s and versions.<br>
+<br>
+=C2=A0 =C2=A0At the time writing, the OpenVPN GUI client supports connecti=
ng to the<br>
+=C2=A0 =C2=A0default Interactive Service instance only.<br>
+<br>
+.. _`Gert&#39;s email`: <a href=3D"https://www.mail-archive.com/openvpn-de=
vel@lists.sourceforge.net/msg00097.html" rel=3D"noreferrer" target=3D"_blan=
k">https://www.mail-archive.com/o<wbr>penvpn-devel@...282...<wbr>.net/msg00=
097.html</a><br>
--<br>
2.15.1 (Apple Git-101)<br><br></blockquote><div><br></div><div>Do you also =
plan to document the service &lt;--&gt; openvpn.exe communication?</div><di=
v>Or is that beyond the scope of this file? Anyway, could be a separate pat=
ch :)</div><div><br></div><div>Thanks,</div><div><br></div><div>Selva=C2=A0=
</div></div></div></div></div>

--0000000000007ec7120569b3d328--

