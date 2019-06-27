MIME-Version: 1.0
References: <CAKuzo_jvYaihBobd14U45epDOB43Dd_Kmhyug7py_+hmFjnCBg@...278...>
 <1561542690-17559-1-git-send-email-lstipakov@...277...>
 <CAKuzo_iGLb=hVgFeJ9JcwdnQoTrp3f6QZr=D4GvhKgcW7At0yQ@...278...>
In-Reply-To: <CAKuzo_iGLb=hVgFeJ9JcwdnQoTrp3f6QZr=D4GvhKgcW7At0yQ@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 27 Jun 2019 13:07:40 +0300
Message-ID: <CAGyAFMUgS+WaDf5Xx8S-jX3MbAu4QT7_Ln86JDtmZEaV2PPLcA@...278...>
Content-Type: multipart/alternative; boundary="000000000000b2ce05058c4b550f"
Subject: Re: [Openvpn-devel] [PATCH v2] openvpnserv: enable interactive
 service to open tun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000b2ce05058c4b550f
Content-Type: text/plain; charset="UTF-8"

Hi,

This only handles dev-node is unspecified. We need the same for
> the case where dev-node specified above this.
>

I never used that, so this has slipped from my attention. Will do.


> We service multiple OpenVPN processes, so a global variable is no good.
>
> Some alternatives:
> (i) Use GetNamedPipeClientProcessId() each time
> (ii) save the processId in undo_lists (this list is local to the service
> thread)
>

GetNamedPipeClientProcessId() returns service process id, since we open
client pipe from service code and pass
handle to openvpn process:

    svc_pipe = CreateFile(ovpn_pipe_name, GENERIC_READ | GENERIC_WRITE, 0,
                          &inheritable, OPEN_EXISTING, 0, NULL);
    openvpn_sntprintf(cmdline, cmdline_size, L"openvpn %s --msg-channel
%lu",
                      sud.options, svc_pipe);

I looked more closely at the code and turns out that instead of global
variable you can just pass process id to HandleMessage():

    CreateProcessAsUserW(pri_token, exe_path, cmdline, &ovpn_sa, NULL, TRUE,
                              settings.priority | CREATE_NO_WINDOW |
CREATE_UNICODE_ENVIRONMENT,
                              user_env, sud.directory, &startup_info,
&proc_info);
    while (TRUE)
    {
        DWORD bytes = PeekNamedPipeAsync(ovpn_pipe, 1, &exit_event);
        HandleMessage(ovpn_pipe, proc_info.hProcess, bytes, 1, &exit_event,
&undo_lists);
    }



> I think we must ensure device_path is null terminated as its received
> over the pipe from a user process. Our utf8to16() just assumes it is.
> There are a few other places where we've this defect but that has to
> be handled in a separate patch.
>

Yep, meanwhile I'll just make sure that it is null terminated for this
specific case:

msg.open_tun.device_path[sizeof(msg.open_tun.device_path) - 1] = '\0';
res.error_number = HandleOpenTunDeviceMessage(&msg.open_tun, ovpn_proc,
&res.handle);


> Need err = GetLastError(); here. Otherwise we're returning success as
> the error code with an invalid handle.
>

Yep.

Selva
>

Thanks for review, V3 is coming.

-- 
-Lev

--000000000000b2ce05058c4b550f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div class=3D"gmail_quote"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">This only handles dev-node =
is unspecified. We need the same for<br>
the case where dev-node specified above this.<br></blockquote><div><br></di=
v><div>I never used that, so this has slipped from my attention. Will do.</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
We service multiple OpenVPN processes, so a global variable is no good.<br>
<br>
Some alternatives:<br>
(i) Use GetNamedPipeClientProcessId() each time<br>
(ii) save the processId in undo_lists (this list is local to the service th=
read)<br></blockquote><div><br></div><div>GetNamedPipeClientProcessId() ret=
urns service process id, since we open client pipe from service code and pa=
ss=C2=A0</div><div>handle to openvpn process:<br></div><div><br></div><div>=
=C2=A0 =C2=A0 svc_pipe =3D CreateFile(ovpn_pipe_name, GENERIC_READ | GENERI=
C_WRITE, 0,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;inheritable, OPEN_EXISTING, 0, NULL);<=
br>=C2=A0 =C2=A0 openvpn_sntprintf(cmdline, cmdline_size, L&quot;openvpn %s=
 --msg-channel %lu&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sud.options, svc_pipe);<br></div><div><br><=
/div><div>I looked more closely at the code and turns out that instead of g=
lobal variable you can just pass process id to HandleMessage():</div><div><=
br></div><div>=C2=A0 =C2=A0 CreateProcessAsUserW(pri_token, exe_path, cmdli=
ne, &amp;ovpn_sa, NULL, TRUE,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 settings.pri=
ority | CREATE_NO_WINDOW | CREATE_UNICODE_ENVIRONMENT,<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 user_env, sud.directory, &amp;startup_info, &amp;proc_info);<=
br>=C2=A0 =C2=A0 while (TRUE)<br>=C2=A0 =C2=A0 {<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 DWORD bytes =3D PeekNamedPipeAsync(ovpn_pipe, 1, &amp;exit_event);<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 HandleMessage(ovpn_pipe, proc_info.hProcess, =
bytes, 1, &amp;exit_event, &amp;undo_lists);<br>=C2=A0 =C2=A0 }<br></div><d=
iv><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
I think we must ensure device_path is null terminated as its received<br>
over the pipe from a user process. Our utf8to16() just assumes it is.<br>
There are a few other places where we&#39;ve this defect but that has to<br>
be handled in a separate patch.<br></blockquote><div><br></div><div>Yep, me=
anwhile I&#39;ll just make sure that it is null terminated for this specifi=
c case:</div><div><br></div><div>msg.open_tun.device_path[sizeof(msg.open_t=
un.device_path) - 1] =3D &#39;\0&#39;;<br>res.error_number =3D HandleOpenTu=
nDeviceMessage(&amp;msg.open_tun, ovpn_proc, &amp;res.handle);<br></div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Need err =3D GetLastError(); here. Otherwise we&#39;re returning success as=
<br>
the error code with an invalid handle.<br></blockquote><div><br></div><div>=
Yep.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Selva<br></blockquote><div><br></div><div>Thanks for review, V3 is coming.<=
/div><div><br></div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"=
>-Lev</div></div>

--000000000000b2ce05058c4b550f--

