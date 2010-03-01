Message-ID: <4B8BAD59.1060908@...1114...>
Date: Mon, 01 Mar 2010 13:04:41 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1267361435-11982-1-git-send-email-openvpn.list@...1114...>
	<20100228142856.GL9556@...1296...>
In-Reply-To: <20100228142856.GL9556@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Add CID to the management status
	overview
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/02/10 15:28, Gert Doering wrote:
> Hi,
> 
> On Sun, Feb 28, 2010 at 01:50:35PM +0100, David Sommerseth wrote:
>> There are commands in the management interface which require the cid. The
>> only way at the moment to get the cid of connected clients is to have
>> always a management connection established. The patch adds the CID to the
>> status output.
> 
> What is "cid"?  Client-ID?
> 
> I can't ACK this, as I don't understand the implications.  The code itself
> looks harmless, but without knowing who might read the output and whether
> an additional field will be silently ignored or whether consumer applications
> may fail, I really can't say.
> 
> Is there documentation available for this?

I've been looking at the management/management-notes.txt file.  And CID
does indicate a Client-ID.  In fact, this ID is required by more of the
commands issued.  But there is no "overview list" which reports it, as
far as I can understand.  Thus putting this into the status command
seems reasonable to me.

The only way to track those CID values is by looking for client
notifications as clients connect and authenticates themselves.


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuLrVkACgkQDC186MBRfrrFzwCgiVbJKcJWpDi2ZJ7Ipewlan1m
f6gAoJjQMfA8uzlcG+ckMO6f1Xyyb1S7
=BnUR
-----END PGP SIGNATURE-----

