MIME-Version: 1.0
From: Jon Chiappetta <root@...2904...>
Date: Sun, 2 Nov 2025 14:52:09 -0500
Message-ID: <CAOh3LPOey9b8wdPv7NeHqZopWgw3f0c-cXsZ+ozWZ7nzyn7s2Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000c469a30642a1ef2e"
References: <CAOh3LPOey9b8wdPv7NeHqZopWgw3f0c-cXsZ+ozWZ7nzyn7s2Q.ref@...278...>
Subject: [Openvpn-devel] One more program crash that I happened to observe
 and catch in GDB - potential free/malloc bug?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>

--000000000000c469a30642a1ef2e
Content-Type: text/plain; charset="UTF-8"

Hi Gert and devs,

During my experimentation with this dual mode, I've had to go through a lot
of the code in the ssl.c library file. While I was tracing and testing my
modifications, I think I found another potential crash path but I'm also
not sure if it was my modifications or if this is indeed a bug potentially.

This was the GDB backtrace I was able to capture during my own modified
testing:



Thread 8 "openvpn" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7fffdffff6c0 (LWP 638500)]
0x00007ffff74add55 in __GI___libc_free (mem=0x2) at ./malloc/malloc.c:3375
warning: 3375   ./malloc/malloc.c: No such file or directory
(gdb) Quit
(gdb) bt
#0  0x00007ffff74add55 in __GI___libc_free (mem=0x2) at
./malloc/malloc.c:3375
#1  0x0000555555564be1 in free_buf (buf=buf@...1851...=0x7fffd40068b0) at
buffer.c:186
#2  0x00005555555e1d04 in key_state_free (ks=ks@...1851...=0x7fffd40065d0,
clear=clear@...1851...=false) at ssl.c:928
#3  0x00005555555e1eca in tls_session_free (session=0x7fffd4005ac8,
clear=false) at ssl.c:1076
#4  0x00005555555e4c29 in tls_multi_free (multi=0x7fffd4003700,
clear=clear@...1851...=true) at ssl.c:1286
#5  0x0000555555586c79 in do_close_tls (c=0x7fffd4000d40) at init.c:3986
#6  close_instance (c=c@...1851...=0x7fffd4000d40) at init.c:4868
#7  0x00005555555872f8 in close_context (c=c@...1851...=0x7fffd4000d40,
sig=sig@...1851...=15, flags=flags@...1851...=1) at init.c:5074
#8  0x000055555559be11 in multi_close_instance (m=m@...1851...=0x7ffff73fd7c0,
mi=0x7fffd4000b70, shutdown=shutdown@...1851...=false) at multi.c:661
#9  0x000055555559cadb in multi_close_instance_on_signal
(m=m@...1851...=0x7ffff73fd7c0,
mi=<optimized out>) at multi.c:3413
#10 0x00005555555a37e4 in multi_io_action (m=m@...1851...=0x7ffff73fd7c0,
mi=0x0, action=<optimized out>, action@...1851...=1, poll=<optimized out>,
    poll@...1851...=false, flags=flags@...1851...=0, z=z@...1851...=1) at multi_io.c:640
#11 0x00005555555a40f4 in multi_io_process_io (b=0x7fffffff7500, f=f@...1851...=0,
z=1) at multi_io.c:466
#12 0x00005555555a4388 in threaded_multi_io_process_io (a=0x7ffff73fd6e0)
at multi_io.c:587
#13 0x00007ffff749caa4 in start_thread (arg=<optimized out>) at
./nptl/pthread_create.c:447
#14 0x00007ffff7529c6c in clone3 () at
../sysdeps/unix/sysv/linux/x86_64/clone3.S:78
(gdb)



I noticed in this ssl.c library file that there is a tls_session_init()
which calls upon key_state_init() for the KS_PRIMARY key ONLY, not
including the LAME_DUCK key.

https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/ssl.c#L1032

key_state_init(session, &session->key[KS_PRIMARY]);

However, this init/malloc call chain does not line up with the associated
and related free method calls. The tls_session_free() method will then
call key_state_free() all ALL keys there after.

https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/ssl.c#L1061

for (size_t i = 0; i < KS_SIZE; ++i)
{
        key_state_free(&session->key[i], false);
}

Now I saw that the lame duck key is eventually initialized during
renegotiation, however, I believe that if a client were to maybe connect
and then reconnect right away that the lame duck key won't be initialized
and potentially cause the crash that I observed above? It may be good for
one of the devs who knows this code base better to explore this mis-match
in init/free calls. :)

For now, as a work around in my dual modification PR, I set a bool variable
in the key state struct object that gets set to true when initialized and
then the free call can later detect that to determine when to properly free
it later!

https://github.com/stoops/openvpn-fork/blob/dual/src/openvpn/ssl.c#L861

ks->keys_init = true;

https://github.com/stoops/openvpn-fork/blob/dual/src/openvpn/ssl.c#L921

if (!ks->keys_init) { return 1; }



Thanks again for your time,
Jon C

--000000000000c469a30642a1ef2e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Gert and devs,<div><br></div><div>During my experimenta=
tion with this dual mode, I&#39;ve had to go through a lot of the code in t=
he ssl.c library file. While I was tracing and testing my modifications, I =
think I found another potential crash path but I&#39;m also not sure if it =
was my modifications or if this is indeed a bug potentially.=C2=A0</div><di=
v><br></div><div>This was the GDB backtrace I was able to capture during my=
 own modified testing:</div><div><br></div><div><br></div><div><br>Thread 8=
 &quot;openvpn&quot; received signal SIGSEGV, Segmentation fault.<br>[Switc=
hing to Thread 0x7fffdffff6c0 (LWP 638500)]<br>0x00007ffff74add55 in __GI__=
_libc_free (mem=3D0x2) at ./malloc/malloc.c:3375<br>warning: 3375 =C2=A0 ./=
malloc/malloc.c: No such file or directory<br>(gdb) Quit<br>(gdb) bt<br>#0 =
=C2=A00x00007ffff74add55 in __GI___libc_free (mem=3D0x2) at ./malloc/malloc=
.c:3375<br>#1 =C2=A00x0000555555564be1 in free_buf (buf=3Dbuf@...1851...=3D=
0x7fffd40068b0) at buffer.c:186<br>#2 =C2=A00x00005555555e1d04 in key_state=
_free (ks=3Dks@...1851...=3D0x7fffd40065d0, clear=3Dclear@...1851...=3Dfals=
e) at ssl.c:928<br>#3 =C2=A00x00005555555e1eca in tls_session_free (session=
=3D0x7fffd4005ac8, clear=3Dfalse) at ssl.c:1076<br>#4 =C2=A00x00005555555e4=
c29 in tls_multi_free (multi=3D0x7fffd4003700, clear=3Dclear@...1851...=3Dt=
rue) at ssl.c:1286<br>#5 =C2=A00x0000555555586c79 in do_close_tls (c=3D0x7f=
ffd4000d40) at init.c:3986<br>#6 =C2=A0close_instance (c=3Dc@...1851...=3D0=
x7fffd4000d40) at init.c:4868<br>#7 =C2=A00x00005555555872f8 in close_conte=
xt (c=3Dc@...1851...=3D0x7fffd4000d40, sig=3Dsig@...1851...=3D15, flags=3Df=
lags@...1851...=3D1) at init.c:5074<br>#8 =C2=A00x000055555559be11 in multi=
_close_instance (m=3Dm@...1851...=3D0x7ffff73fd7c0, mi=3D0x7fffd4000b70, sh=
utdown=3Dshutdown@...1851...=3Dfalse) at multi.c:661<br>#9 =C2=A00x00005555=
5559cadb in multi_close_instance_on_signal (m=3Dm@...1851...=3D0x7ffff73fd7=
c0, mi=3D&lt;optimized out&gt;) at multi.c:3413<br>#10 0x00005555555a37e4 i=
n multi_io_action (m=3Dm@...1851...=3D0x7ffff73fd7c0, mi=3D0x0, action=3D&l=
t;optimized out&gt;, action@...1851...=3D1, poll=3D&lt;optimized out&gt;, <=
br>=C2=A0 =C2=A0 poll@...1851...=3Dfalse, flags=3Dflags@...1851...=3D0, z=
=3Dz@...1851...=3D1) at multi_io.c:640<br>#11 0x00005555555a40f4 in multi_i=
o_process_io (b=3D0x7fffffff7500, f=3Df@...1851...=3D0, z=3D1) at multi_io.=
c:466<br>#12 0x00005555555a4388 in threaded_multi_io_process_io (a=3D0x7fff=
f73fd6e0) at multi_io.c:587<br>#13 0x00007ffff749caa4 in start_thread (arg=
=3D&lt;optimized out&gt;) at ./nptl/pthread_create.c:447<br>#14 0x00007ffff=
7529c6c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78<br>(g=
db)</div><div><br></div><div><br></div><div><br></div><div>I noticed in thi=
s ssl.c library file that there is a=C2=A0tls_session_init() which calls up=
on=C2=A0key_state_init() for the KS_PRIMARY key ONLY, not including the LAM=
E_DUCK key.=C2=A0</div><div><br></div><div><a href=3D"https://github.com/Op=
enVPN/openvpn/blob/master/src/openvpn/ssl.c#L1032">https://github.com/OpenV=
PN/openvpn/blob/master/src/openvpn/ssl.c#L1032</a><br></div><div><br></div>=
<div>key_state_init(session, &amp;session-&gt;key[KS_PRIMARY]);<br></div><d=
iv><br></div><div>However, this init/malloc call chain does not line up wit=
h the associated and related free method calls. The=C2=A0tls_session_free()=
 method will then call=C2=A0key_state_free() all ALL keys there after.=C2=
=A0</div><div><br></div><div><a href=3D"https://github.com/OpenVPN/openvpn/=
blob/master/src/openvpn/ssl.c#L1061">https://github.com/OpenVPN/openvpn/blo=
b/master/src/openvpn/ssl.c#L1061</a><br></div><div><br></div><div>for (size=
_t i =3D 0; i &lt; KS_SIZE; ++i)<br>{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 key_st=
ate_free(&amp;session-&gt;key[i], false);<br>}<br></div><div><br></div><div=
>Now I saw that the lame duck key is eventually initialized during renegoti=
ation, however, I believe that if a client were to maybe connect and then r=
econnect right away that the lame duck key won&#39;t be initialized and pot=
entially cause the crash that I observed above? It may be good for one of t=
he devs who knows this code base better to explore this mis-match in init/f=
ree calls. :)=C2=A0</div><div><br></div><div>For now, as a work around in m=
y dual modification PR, I set a bool variable in the key state struct objec=
t that gets set to true when initialized and then the free call can later d=
etect that to determine when to properly=C2=A0free it later!</div><div><br>=
</div><div><a href=3D"https://github.com/stoops/openvpn-fork/blob/dual/src/=
openvpn/ssl.c#L861">https://github.com/stoops/openvpn-fork/blob/dual/src/op=
envpn/ssl.c#L861</a><br></div><div><br></div><div>ks-&gt;keys_init =3D true=
;<br></div><div><br></div><div><a href=3D"https://github.com/stoops/openvpn=
-fork/blob/dual/src/openvpn/ssl.c#L921">https://github.com/stoops/openvpn-f=
ork/blob/dual/src/openvpn/ssl.c#L921</a><br></div><div><br></div><div>if (!=
ks-&gt;keys_init) { return 1; }<br></div><div><br></div><div><br></div><div=
><br></div><div>Thanks again for your time,</div><div>Jon C</div><div><br><=
/div><div><br></div><div><br></div><div><br></div><div><br></div><div><br><=
/div><div>=C2=A0<br></div></div>

--000000000000c469a30642a1ef2e--

