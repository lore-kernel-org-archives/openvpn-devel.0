MIME-Version: 1.0
From: Jon Chiappetta <root@...2904...>
Date: Thu, 30 Oct 2025 12:37:13 -0400
Message-ID: <CAOh3LPPheyga_3PGvB_hpxmc5owZm6=03NYDdFmqutmwqKQMHQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000225444064262dda0"
References: <CAOh3LPPheyga_3PGvB_hpxmc5owZm6=03NYDdFmqutmwqKQMHQ.ref@...278...>
Subject: [Openvpn-devel] One more final OpenVPN modification implemented --
 Dual Mode!
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--000000000000225444064262dda0
Content-Type: text/plain; charset="UTF-8"

So, I'm presently testing this change out on my personal home network wide
VPN setup but I think I finally was able to implement one of the original
design goals that I had in mind. Whenever I wrote proxy applications, I
would always separate out the read-client and write-server direction from
the read-server and write-client direction. When I first tried this with
OpenVPN, I could not do so because there was only a single PRIMARY
negotiated session key as well as some other shared buffer variables which
were conflicting and causing errors.

I spent several days trying to work through the SSL code paths and was able
to finally implement a secondary negotiated session key state which helps
with separating out the read and write pipelines in both the client and
server mode of operations. I call this mode, --dual-mode (which really
depends on my previous clean up code that I did in the original --bulk-mode
and --mtio-mode) and it is able to achieve some pretty nice and snappy
performance on behalf of my entire network (also thanks to the basic
connection state tracking solution)!

In case you're interested to see any of the commit code details itself:

Blog Post:
https://fossjon.com/2025/10/30/finally-able-to-insert-a-proper-layer-of-bi-directional-multi-threaded-set-of-core-operations-to-the-highly-modified-openvpn-source-code/

Commit Code: https://github.com/stoops/openvpn-fork/compare/mtio...dual
Pull Request: https://github.com/OpenVPN/openvpn/pull/884
Complete Commits:
https://github.com/stoops/openvpn-fork/compare/master...bust

Thanks again for all your work and time on this great open source project!
Jon C

--000000000000225444064262dda0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">So, I&#39;m presently testing this change out on my person=
al home network wide VPN setup but I think I finally was able to implement =
one of the original design goals that I had in mind. Whenever I wrote proxy=
 applications, I would always separate out the read-client and write-server=
 direction=C2=A0from the read-server and write-client direction. When I fir=
st tried this with OpenVPN, I could not do so because there was only a sing=
le PRIMARY negotiated session key as well as some other shared buffer varia=
bles which were conflicting and causing errors.=C2=A0<div><br></div><div>I =
spent several days trying to work through the SSL code paths and was able t=
o finally implement a secondary negotiated session key state which helps wi=
th separating out the read and write pipelines in both the client and serve=
r mode of operations. I call this mode, --dual-mode (which really depends o=
n my previous clean up code that I did in the original --bulk-mode and --mt=
io-mode) and it is able to achieve=C2=A0some pretty=C2=A0nice and snappy pe=
rformance on behalf of my entire network (also thanks to the basic connecti=
on state tracking solution)!</div><div><br></div><div>In case you&#39;re in=
terested to see any of the commit code details itself:</div><div><br></div>=
<div>Blog Post:=C2=A0<a href=3D"https://fossjon.com/2025/10/30/finally-able=
-to-insert-a-proper-layer-of-bi-directional-multi-threaded-set-of-core-oper=
ations-to-the-highly-modified-openvpn-source-code/">https://fossjon.com/202=
5/10/30/finally-able-to-insert-a-proper-layer-of-bi-directional-multi-threa=
ded-set-of-core-operations-to-the-highly-modified-openvpn-source-code/</a><=
/div><div><br></div><div>Commit Code: <a href=3D"https://github.com/stoops/=
openvpn-fork/compare/mtio...dual">https://github.com/stoops/openvpn-fork/co=
mpare/mtio...dual</a><br>Pull Request: <a href=3D"https://github.com/OpenVP=
N/openvpn/pull/884">https://github.com/OpenVPN/openvpn/pull/884</a><br>Comp=
lete Commits: <a href=3D"https://github.com/stoops/openvpn-fork/compare/mas=
ter...bust">https://github.com/stoops/openvpn-fork/compare/master...bust</a=
><br></div><div><br></div><div>Thanks again for all your work and time on t=
his great open source project!</div><div>Jon C</div><div><br></div></div>

--000000000000225444064262dda0--

