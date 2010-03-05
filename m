From: "Michael H. Warfield" <mhw@...1243...>
In-Reply-To: <20100305080138.GG25238@...1296...>
References: <6c75f86b.6552e8f7.4b8bad61.2e7bd@...1309...>
	<4B8BB647.2020804@...1114...>
	<23627cf8.610acd4b.4b8bc540.d2023@...1309...>
	<eba800c91003011101v61fb1415l68146f00916b1c7@...278...>
	<7cd17813.52db77fa.4b901800.4e59d@...1309...>
	<20100304213523.GF25238@...1296...>
	<1267744903417725500@...1315...>
	<20100305080138.GG25238@...1296...>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-DIH4shPCbDlXTbJ+HIN7"
Date: Fri, 05 Mar 2010 09:42:17 -0500
Message-ID: <1267800137.8210.25.camel@...23...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] Openvpn 2.1.1 bad tcp performance but good
 pingwhen -l 1472 (with packet size = MTU)
Reply-To: mhw@...1243...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: mhw@...1243..., openvpn-devel@lists.sourceforge.net

--=-DIH4shPCbDlXTbJ+HIN7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-03-05 at 09:01 +0100, Gert Doering wrote:=20
> Hi,
>=20
> On Thu, Mar 04, 2010 at 05:21:43PM -0600, openvpn@...1315... wrote:
> > I did this in the client configuration file ... is this right?
> > I checked the OpenVPN web site, and it may be that I need this on
> > the server side instead. Please clarify and I'll try it again (if
> > I need to).
>=20
> "socket-flags TCP_NODELAY"

> that would need to go into both(!) config files - it changes the way the
> operating system handles write() calls into a socket, that is, whether
> the OS waits for "more data" to eventually generate a full sized packet,
> or whether it will send the data immediately (generating a small packet).

> (This is a fundamental problem with TCP - the stacks are optimized for
> certain patterns, either "bulk data, make full size packets" or=20
> "interactive traffic, send single bytes of keystrokes, where a few ms
> delay don't hurt", but not for VPN-like traffic)

Oh WOW...  I hadn't even thought of that.  That's got to be the A #1
reason right there for avoiding the use of tcp like the plague for
things like these.

That means that OpenVPN is (to use the older terminology - I'm old
school) not using the PUSH OOB method to push packets out and to get
them received immediately at the other end.  Looking that the
socket_write calls, that would seem to be the MSG_OOB option.  I use to
remember in days ancient using TCP_URGENT and TCP_PUSH flags for things
like that (TCP_URGENT was used by ftp clients to abort interrupted data
streams).  All I see in socket.h is "MSG_NOSIGNAL".  Yeah, that would
probably do it.  TCP_NODELAY is going to disable the naggle algorithm
and disable the send buffering but I don't think it's going to set the
TH_PUSH flag in the tcp header so what the received side does with it is
up to the received side, isn't it?  Yeah, I know, PUSH is an optional
feature in tcp implementations but it's been in every one I've worked
with and I see the comments about it having it's own problems.  But how
in the world would anyone expect a user space packet handler to work
efficiently over tcp STREAMS without it?  You've got to work around
tcp's design to treat everything as a continuous stream and to optimize
it as a stream and not a series of packets.

If nothing else, I would always expect tcp vpn's the suck royally
without at least having TCP_NODELAY.  Why isn't that the default.

http://www.unixguide.net/network/socketfaq/2.11.shtml

> gert

Mike
--=20
Michael H. Warfield (AI4NB) | (770) 985-6132 |  mhw@...1243...
   /\/\|=3Dmhw=3D|\/\/          | (678) 463-0932 |  http://www.wittsend.com=
/mhw/
   NIC whois: MHW9          | An optimist believes we live in the best of a=
ll
 PGP Key: 0x674627FF        | possible worlds.  A pessimist is sure of it!

--=-DIH4shPCbDlXTbJ+HIN7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEVAwUAS5EYSMDrlnVnRif/AQJgwgf7BgwiPjThE5rPwdP/pmGbPEktGpOBEOak
k04Gl8AmOSAN3BhPbzhI6ornOktIkldUJCXH58jBNo2awIlbi4yvuP3Ao77ypn83
TXi8zTb6iGR7N716K2HVnxIVJXtuN49jPXN4QsL0yAzAfMscOwhIqgRxcEWiwX32
t7AifJpMNQ0tbaLyLsPCd56v1ZVlfS1iCmZNYIybSjevLkwGZ0a2gTaq3yw15psU
gvNOCEKgoLT8QNiRMH9D/PqJyaZ50JOQudDxRspHm9dGsaEeY0pVdmBkCFanMgLD
9tLOSwpq+MlDhw0UiDzatc+SOScWLwUOeRlou97zQ4ATG/1Whs2Z1A==
=GbzY
-----END PGP SIGNATURE-----

--=-DIH4shPCbDlXTbJ+HIN7--


