Message-ID: <4B474F26.5060801@...1114...>
Date: Fri, 08 Jan 2010 16:28:38 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <lypr5lvsu7.fsf@...1290...>
In-Reply-To: <lypr5lvsu7.fsf@...1290...>
Subject: [Openvpn-devel] RFE: allow 'lport 0' setup for random port binding
	(arrived in [Openvpn-users])
Reply-To: Enrico Scholz <enrico.scholz@...1291...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: Enrico Scholz <enrico.scholz@...1291...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Resending it to openvpn-devel list, to hit the right audience.

kind regards,

David Sommerseth


On 08/01/10 10:39, Enrico Scholz wrote:
> Hi,
> 
> I am running a multihomed host where 'local <extip>' must be specified
> for proper operation.  Unfortunately, this implies 'lport 1194' or
> another static port. 
> 
> This causes problems with stateful firewalls which register the host/port
> pairs in the internal connection tracking table. On ungraceful reconnects,
> the new TCP connection will have same the host/port pairs but unexpected
> sequence numbers. The new connection will be assumed as invalid hence and
> be dropped.
> 
> It would be nice when local port can be configured to be bound to a
> random port number.  After reading code,
> 
> |    else if (streq (p[0], "lport") && p[1])
> |  ...
> |        port = atoi (p[1]);
> |-       if (!legal_ipv4_port (port))
> |+       if (port != 0 && !legal_ipv4_port (port))
> |          {
> 
> in options.c seems to be the only required change.
> 
> 
> 
> Enrico

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAktHTyMACgkQDC186MBRfrrceACfT7IdVvNZU5VxIVQG1A19pmue
4dEAn1FEYwDky5BekueF/rELX7jVOfUK
=zjPt
-----END PGP SIGNATURE-----

