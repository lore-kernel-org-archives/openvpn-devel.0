Date: Mon, 14 Mar 2011 20:06:26 -0300
From: Federico Heinz <fheinz@...277...>
Message-ID: <20110314200626.450b6853@...1451...>
In-Reply-To: <20110314083845.GL9835@...1296...>
References: <20110312184423.3fee2f17@...1451...>
	<20110312215420.31033.qmail@...1287...>
	<20110312195923.55eaa915@...1451...>
	<20110312232602.10422.qmail@...1287...>
	<20110312213345.694340df@...1451...>
	<20110313014000.27475.qmail@...1287...>
	<20110313142200.GJ9835@...1296...>
	<20110313160421.3004.qmail@...1287...>
	<20110313173833.GK9835@...1296...>
	<20110313231620.12432.qmail@...1287...>
	<20110314083845.GL9835@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	boundary="Sig_/bkiMn5yqMORoX6olLKN/0s4";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH] Bind only to specified interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--Sig_/bkiMn5yqMORoX6olLKN/0s4
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

On 14/03/2011, Gert Doering wrote:
> > [...] Multiple openvpn daemons on different interfaces and
> > same port.
> That's one possible use case, but not how I understood Federico.

That's part of my use case, not all.

Please let me summarize what I've read in this discussion:

  * some people are unconvinced there's a real use case for
    specifying an interface OpenVPN should use as local, and therefore
    there's no need for action. I have tried to explain that a use
    case exists, in connection with multiple ISPs and, being
    confronted with just such a use case, I find it hard to agree
    with them.
  * some other people agree that there is a use case, but propose
    different ways of approaching the problem through various
    mechanisms to resolve the interface name to an IP address before
    passing it on to OpenVPN. The disagreement here seems to be in
    how such a use case should be handled. Sure, those approaches
    work, and I tried them myself before diving into the source
    code. The problem is I don't think that a supported use case
    should need such involved procedures, and while these may be
    more or less complicated, none of them is as simple as being
    able to specify "if:pppo" in the 'local' directive. As a matter
    of fact, the last suggestion from Peter has more code in it than
    the code portion of my suggested patches.

I don't know what else I can do to show the first group of people
that a use case exists, even if they aren't confronted with it. As to
the second group of people, I guess it's a matter of drawing a line:
at one end of the spectrum, we could do away with OpenVPN altogether
and implement it in shell code, at the other end we would have a
gazillion configuration options so that we could turn OpenVPN into an
HTTP server just touching config files.

I think the proposed change would be a useful addition to the
project, but I respect your judgement if you disagree.

	Fede

--Sig_/bkiMn5yqMORoX6olLKN/0s4
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iD8DBQFNfp9ybPULDL0CxuARAr+nAKC7okcylvcW47wNhj97uUQ2Uu76fACePeVA
zEyeVUbggTxXjA3eCq1hRcQ=
=if1R
-----END PGP SIGNATURE-----

--Sig_/bkiMn5yqMORoX6olLKN/0s4--

