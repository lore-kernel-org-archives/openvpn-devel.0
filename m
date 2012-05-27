MIME-Version: 1.0
In-Reply-To: <20120527202737.GV1161@...1296...>
References: <20120527202737.GV1161@...1296...>
Date: Sun, 27 May 2012 23:36:57 +0300
Message-ID: <CAOazyz0LD6ykOFcxcRTvu95Sjkzcsg2+FxT7514Ki3+QW9Dbsw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] build revolution lost t_client test?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

t_client.sh requires root/sudo privileges.
"make check" should not assume any special privilege.
Because of this it is removed from "make check".
You can still run this by hand or we can add special target such as
"make root-check" or similar.

On Sun, May 27, 2012 at 11:27 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> working on the test server, I noticed that t_client.sh was no longer run
> from "make check", and that it lost "read t_client.rc from build dir"
> (which is needed when building different clients from a common source
> dir, and wanting to run t_client with different option sets).
>
> The attached patch restores lost functionality, and adds one extra
> feature, optionally waiting longer for OpenVPN startup (if the server
> has a high RTT, 10 seconds is not always enough).
>
> David, this has been tested on FreeBSD 7.4 (so far) and is essential
> for the buildbot client tests :-) - more platform tests will follow
> as soon as I have all the server stanzas up and running.
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //www.muc.de/~gert/
> Gert Doering - Munich, Germany =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gert@...1296...
> fax: +49-89-35655025 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gert@...1297...
>
> -------------------------------------------------------------------------=
-----
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

