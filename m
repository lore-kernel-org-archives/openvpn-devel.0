Date: Wed, 23 Oct 2013 16:18:29 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20131023141829.GA13900@...1296...>
References: <CAN_jwOsXhs-qTqOmrqhNk+Jf6-pRSBVVTovShLGgQAKKTZkE4g@...278...>
	<554440252.59882.1380270883311.JavaMail.zimbra@...1795...>
	<CAN_jwOvixY5Jz7Rheq-=o40saprsoQmxRB9yn3-jdCmFa9VM0A@...278...>
	<52456F61.3000104@...1114...>
	<CAN_jwOt4kiM09YjZi5=jh6qFgQTpLFgPOSO1opFOF72EY8fyCw@...278...>
	<CAN_jwOuJcwF-Co0r=pukUHO2z0a0ff5xtERp7_mc2PYot9yv-Q@...278...>
	<CAN_jwOuQR6rxUTA5Nho9tBkvSBMU75Yzfv=PFpFUHa2Kq8=E2A@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <CAN_jwOuQR6rxUTA5Nho9tBkvSBMU75Yzfv=PFpFUHa2Kq8=E2A@...278...>
Subject: Re: [Openvpn-devel] Does openvpn 2.3.2 has memory leak?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Brad Zhang <hebei5000@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--wac7ysb48OaltWcw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Oct 06, 2013 at 09:21:46PM +0800, Brad Zhang wrote:
> Do you have some idea about this issue?  Looking forward to your reply.

Coming back to *this* thread, after some debugging in the other thread
with Arno, I think what I can say so far is that we're observing two
different things:

 - the first renegotiation brings a big jump in memory, but this is to
   be expected, because the new keying material needs extra memory, and
   the memory for the old key is not released right away (it seems to be
   released at the next renegotiation, or at client disconnect - I've=20
   seen VSZ/RSS go down(!) when clients disconnect, so that seems to
   work right).  This is the "big" jump in memory consumption which is
   actually killing Arno's setup, because there is not enough virtual
   memory available to hold all that is needed for 3000 clients (but
   that can be fixed by increasing max-memory limits if there is enough=20
   RAM).

 - each further renegotiation leaks "a few kbyte" of memory per client,
   which should also be fully returned when the client disconnects - this
   is the issue I discovered earlier, with the GC handling of the per-client
   environment set, and I'll send a patch for that "soon" (as soon as I
   have fully understood the code involved).

Now, what I do not really understand is why the memory consumption on the
3rd, 4th, 5th renegotiation seems to slow down - there seems to be some
additional memory fragmentation involved in the 2nd+3rd renegotiation,
which leads to memory re-use later on.  Or so.

Testing this with "reneg-sec 60" is actually quite interesting...  here's
*disconnect* of a client:

USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root     19892  0.0  0.0   7052  4304 pts/7    SN+  17:48   0:01 openvpn ..=
/serv
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root     19892  0.0  0.0   6300  3740 pts/7    SN+  17:48   0:01 openvpn ..=
/serv

... so you can see that memory is returned to the OS.  (I think this will
not be visible if many clients are connected as the free()ed memory will
be "somewhere in the middle" - but disconnecting *all* clients should also
show memory being returned)

Now going to stare more at the code... :-)

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUmfatakuBuNlUUl1AQKSuwP/a6Yihafex9c35StoIZLmbK2tbI0erlrN
a9VquoNS0ubk33P0/20bd0l8h1v40QWN+W0YtJVl57Ay6v+lEIwE8hrQ5ur7QsLW
Ud15JS4ymGSBJOZlhcjybblAicma++bD1nCynAINgJ3/t7MgNJNoAuTWi4Nkeq/P
QKAZUHexx18=
=FqnU
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--

