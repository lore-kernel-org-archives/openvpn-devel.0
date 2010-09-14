Date: Tue, 14 Sep 2010 09:40:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100914074032.GA10703@...1296...>
References: <54C854C313159D429F344FB1DE1A6526110D96A5@...1403...>
	<4C8E9E7B.9020308@...1299...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0a51aUHJSNYMigeV"
Content-Disposition: inline
In-Reply-To: <4C8E9E7B.9020308@...1299...>
Subject: Re: [Openvpn-devel] Enhancements.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jason Haar <Jason.Haar@...1299...>
Cc: openvpn-devel@lists.sourceforge.net

--0a51aUHJSNYMigeV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Sep 14, 2010 at 09:58:19AM +1200, Jason Haar wrote:
>  On 09/14/2010 08:52 AM, Brad Dameron wrote:
> > Also can there be reporting added for the server side to show what
> > version the client is connecting with?
>
> I agree. I have previously asked for client version and OS to be
> "pushed" during the initial phase so that the server can be decisions
> based on it.=20

As far as I understand the code (check_incoming_control_channel_dowork()
in forward.c) this should be doable without breaking compatibility to
older servers - new control messages can be added, and a server that
does not understand them will just log a warning:

...
          if (buf_string_match_head_str (&buf, "AUTH_FAILED"))
            receive_auth_failed (c, &buf);
          else if (buf_string_match_head_str (&buf, "PUSH_"))
            incoming_push_message (c, &buf);
          else if (buf_string_match_head_str (&buf, "RESTART"))
            server_pushed_restart (c, &buf);
          else
            msg (D_PUSH_ERRORS, "WARNING: Received unknown control message:=
 %s",
 BSTR (&buf));


So...

 - someone needs to specify the control message

 - someone needs to implement sending it on the client side

 - someone needs to think about the planned-usage on the server side
   (present at management interface? put into environment for scripts/
   plugins?  if yes, structured environment variables or just one big
   "lump" with whatever the client puts in there?)

 - someone needs to implement parsing the control message on the server
   side and distribute the resulting information to server-side config
   structures and to plugins/scripts

 - someone else needs to review and ACK.


I'm fairly busy with the IPv6 stuff (and with earning a living), so I won't
implement this, but I'm happy to help with it - bounce ideas around,=20
discuss in #openvpn-devel on irc.freenode.net, etc.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--0a51aUHJSNYMigeV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTI8m8KkuBuNlUUl1AQLuvgQAtfFK1s2OsdNBYJnqelJ2F1Dl1OHD69wK
oTvbPWxFfy9U4CADudEXaL0/h+1F5zMgWcpAR4PeUwjD0Dues550Lpg6ftgX7idM
GNfvPgKO9HpNAJyAVxnrHcQvDbivw8cv31a9x6UiI8+ha6IvuPkHpC0Bt3R8miQZ
aQyKYbibbNk=
=rkCQ
-----END PGP SIGNATURE-----

--0a51aUHJSNYMigeV--

