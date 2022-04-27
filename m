MIME-Version: 1.0
References: <20220427074828.6283-1-kprovost@...2661...>
 <20220427074828.6283-2-kprovost@...2661...>
 <761e5640-6d43-d25b-4845-25698d2e0688@...2181...>
In-Reply-To: <761e5640-6d43-d25b-4845-25698d2e0688@...2181...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 27 Apr 2022 15:32:53 +0300
Message-ID: <CAGyAFMXA0YdQtOFUJ0ShANVJeZ9gLv1Y4DB0_xN7E6-_d4Va3A@...278...>
Content-Type: multipart/alternative; boundary="000000000000d3078505dda20257"
Subject: Re: [Openvpn-devel] [PATCH] Handle (DCO) timeouts in client mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Kristof Provost <kprovost@...2661...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--000000000000d3078505dda20257
Content-Type: text/plain; charset="UTF-8"

Hi,

@Lev, just a heads up: does dco-win deal with this case? It would be
> good to have a look on your side too.
>

Good point - this functionality (dco keepalive timeout) works in openvpn3
but not in openvpn2.

dco-win notifies userspace about keepalive timeout by returning certain
error code (STATUS_CONNECTION_DISCONNECTED in kernel
which translates to GetLastError 64 ERROR_NETNAME_DELETED, don't ask me
why) in response to read request, so we should catch it
inside read_incoming_link() after link_socket_read() call. Will do.

-- 
-Lev

--000000000000d3078505dda20257
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><div dir=3D"ltr"><br></div><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
@Lev, just a heads up: does dco-win deal with this case? It would be <br>
good to have a look on your side too.<br></blockquote><div><br></div><div>G=
ood point - this functionality (dco keepalive timeout) works in openvpn3 bu=
t not in openvpn2.</div><div><br></div><div>dco-win notifies userspace abou=
t keepalive timeout by returning certain error code (STATUS_CONNECTION_DISC=
ONNECTED in kernel</div><div>which translates to GetLastError 64 ERROR_NETN=
AME_DELETED, don&#39;t ask me why) in response to read request, so we shoul=
d catch it</div><div>inside read_incoming_link() after link_socket_read() c=
all. Will do.</div><div><br></div></div>-- <br><div dir=3D"ltr" class=3D"gm=
ail_signature">-Lev</div></div>

--000000000000d3078505dda20257--

