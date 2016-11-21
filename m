Date: Mon, 21 Nov 2016 16:12:56 +0100
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20161121151255.zekib4xujdtkgk4i@...30...>
References: <20161121091013.imxgfilt3byyqu7u@...30...>
	<19b05d6f-1eee-87b8-0e2a-ac0803811a2e@...515...>
	<1187af34-3a3d-766c-94b9-9500c5bfc26b@...2080...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xamztkitrf4w72v2"
Content-Disposition: inline
In-Reply-To: <1187af34-3a3d-766c-94b9-9500c5bfc26b@...2080...>
Content-Transfer-Encoding: 7bit
Subject: Re: [Openvpn-devel] Preparing 2.4-beta1 upload to Debian
 (Experimental)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--xamztkitrf4w72v2
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Mon, Nov 21, 2016 at 03:37:45PM +0100, David Sommerseth wrote:
> On 21/11/16 14:32, Samuli Sepp=E4nen wrote:
> > Il 21/11/2016 11:10, Alberto Gonzalez Iniesta ha scritto:
> >> Hi,
> >>=20
> >> I'm preparing an upload to Debian Experimental of 2.4-beta1 in
> >> order to get the maximum exposition as possible. In the meantime
> >> I'd like to know your opinion on the following patch that I've
> >> been applying to Debian's package for some years:=20
> >> https://bugs.debian.org/cgi-bin/bugreport.cgi?att=3D1;bug=3D367716;fil=
ename=3Dopenvpn_367716.diff;msg=3D10
> >>
> >>=20
> Fixing this:
> >> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D367716
> >>=20
> >> Thanks,
> >>=20
> >> Alberto
> >=20
> > That bug report is mighty old, from 2008. I wonder if the problem
> > still persists at all?
>=20
> I hope at least Arne can chime in on this one, as he has done
> tremendous work on the socket code.  And I'd be surprised if this
> patch applies cleanly on top of our master branch.

No, I doesn't. But I updated it to 2.4. Find it attached.

> Yes, it's an old issue.  But from my brief 3 minutes look at socket.c,
> I'd say it looks like to me this is still needed.  The explanation in
> the patch makes sense.

Yep, I think it's still needed.

Regards,

Alberto




> -------------------------------------------------------------------------=
-----

> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
mailto/sip: agi@...64... | en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 5347 CBD8 3E30 A9EB 4D7D  4BF2 009B 3375 6B9A AA55

--xamztkitrf4w72v2
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="close_socket_before_scripts.patch"

Description: Set socket's FD_CLOEXEC flag before calling up script
 Moving the set_cloexec() call from link_socket_init_phase2() to
 link_socket_init_phase1().
Author: Julien Cristau <jcristau@...334...>
Bug-Debian: http://bugs.debian.org/367716

Index: openvpn/src/openvpn/socket.c
===================================================================
--- openvpn.orig/src/openvpn/socket.c	2016-11-21 09:58:03.562096178 +0100
+++ openvpn/src/openvpn/socket.c	2016-11-21 10:01:20.143091482 +0100
@@ -1625,6 +1625,10 @@
       }
       resolve_remote (sock, 1, NULL, NULL);
     }
+
+  /* set socket file descriptor to not pass across execs, so that
+     scripts don't have access to it */
+  set_cloexec (sock->sd);
 }
 
 static
@@ -1677,10 +1681,6 @@
   /* set socket to non-blocking mode */
   set_nonblock (sock->sd);
 
-  /* set socket file descriptor to not pass across execs, so that
-     scripts don't have access to it */
-  set_cloexec (sock->sd);
-
   if (socket_defined (sock->ctrl_sd))
     set_cloexec (sock->ctrl_sd);
 

--xamztkitrf4w72v2--

