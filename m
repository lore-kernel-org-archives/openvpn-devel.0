Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170701112951.19119-1-steffan@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <b67daad4-362b-3605-5716-3e17c5f0c362@...2080...>
Date: Mon, 14 Aug 2017 12:36:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170701112951.19119-1-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Sx4srNpQJPWxv35pE5fBEs0ieHw4SHeLH"
Subject: Re: [Openvpn-devel] [PATCH] Deprecate --keysize
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Sx4srNpQJPWxv35pE5fBEs0ieHw4SHeLH
Content-Type: multipart/mixed; boundary="Tf0So1IuWQeh0bIQurGhRS52wH9txns4D";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <b67daad4-362b-3605-5716-3e17c5f0c362@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Deprecate --keysize
References: <20170701112951.19119-1-steffan@...1856...>
In-Reply-To: <20170701112951.19119-1-steffan@...1856...>

--Tf0So1IuWQeh0bIQurGhRS52wH9txns4D
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 01/07/17 13:29, Steffan Karger wrote:
> The --keysize option can only be used with already deprecated ciphers,
> such as CAST5, RC2 or BF.  Deviating from the default keysize is
> generally not a good idea (see man page text), and otherwise only
> complicates our code.>
> (If this patch is accepted, I'll send a follow-up patch to remove the
> option from the master branch.)

I agree to the wanted intention of this change.  But, it hits badly if
we remove --keysize on configurations still enforcing BF-CBC with
--keysize 256.  I don't have any numbers of how many users uses it; but
I know many have preferred BF-CBC for a long time - at least before
SWEET32 came and hit us all.  Bare in mind that BF-CBC was the default
since 2002-ish (probably even longer, if considering the OpenVPN v1.x
branch). And many have added --cipher BF-CBC in their configs despite it
was the default.

As long as BF-CBC is available, we cannot remove --keysize.  And to
remove BF-CBC support, I think that needs a bit longer timespan than
v2.5.  Users *must* be far better prepared for that and we need to make
loud and clear announcements with such a change.

Yes, in all this, I know that NCP is a nice rescue.  As long as everyone
either runs v2.4 everywhere or deploys --ncp-ciphers and starts the
migration.  But I've lost confidence that the vast majority of our users
pays closely attention to such feature changes - thus they won't notice
until it stops working.  We need to PUSH this information into their
faces, with large posters carrying promises of rainbow coloured unicorns
if they comply today(!).  In addition to adding clear warnings in the
log files for a looong time.

So I propose:

- We add the warning about removing --keysize for both v2.4 and v2.5.

- Add a warning in v2.4 and v2.5 that ciphers with block sizes < 128
  bits will be *removed* in v2.6

- When removing those ciphers in v2.6, we can remove --keysize together
  with the ciphers, as it will no longer be valid.  But --keysize needs
  to be a NOP for some time (with a warning it has no effect), to avoid
  OpenVPN stopping to run on upgrades.

- Ensure these changes are synchronised within OpenVPN 3 as well

- Start a new wiki page: "How-To: Migrate to secure and modern
  OpenVPN configurations" where we list all deprecated features/options
  and their replacement (including examples).  We also need to have a
  description on the reasoning for deprecating and removing these
  options.

- And the most tricky one: Get some publicity that OpenVPN is going to
  deprecate and remove support for weak ciphers out to the public.  Not
  just on crypto focused sites, but more broadly reaching "media
  channels".   (I believe we can facilitate some of the PR work done by
  the company, but we do need more than that).  Channels/sites I'm
  pondering on:

   ~ An official Press Release by the company? (Samuli and I can check)
   ~ twitter (via the @OpenVPN account)
   ~ reddit? (and similar sites)
   ~ LWN.net
   ~ arstechnica
   ~ ThreatPost
   ~ OS Distribution channels (blog posts, mailing lists, etc)
   ~ Our own wiki and web pages
   ~ others?

  The first round is to clearly state that BF-CBC, CAST and RC2 are
  deprecated and their support will be removed in a coming release (not
  mentioning version, on purpose!).  Users are strongly advised to
  upgrade to OpenVPN v2.4 or server and client side instantly, to
  benefit from NCP (byt more less-tech worded) and to point at the
  "How-To" described above.

  And then we try to re-iterate this once again with the release of
  v2.5 and v2.6.


I know and understand this hurts security focused people, and probably
in even more those who understand crypto very well.  But my personal
experience is that the average users are usually less understanding than
security minded people.  (Yes, I've burnt my, and other's, fingers
within the Fedora community with the v2.4 upgrade)


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--Tf0So1IuWQeh0bIQurGhRS52wH9txns4D--

--Sx4srNpQJPWxv35pE5fBEs0ieHw4SHeLH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZkX0YAAoJEIbPlEyWcf3yEBEQAKTDcatt6hrakeoaiSaIT+4b
9wrNvFqqE9geiH8EYlnEEjvkx7QtuiIIQS+R/9fzmGSiWEsvP5BZsbT8GHjoJJPM
K97H5kklsWAuP52TR9idwvFBY7kceOec7qvOs3baGJm4jtz6pQlrRA8VLmdYaWY/
Ico0oH0JtEICuHjMJNPWZfzOzkiHMklIqwmWMeUlI5eEPtYWPDSs5quCFDk/pnGU
yYPhU4r9Db5k1S/G/MjCaJzJgPVWqa2Tx2T6xROuDXZWhk6NB60xyiPhGOmkMwki
XK/INL/xah9+fCk7BCFpYCIUy/nYsYFSXYUIkijYgD8732gz5ZzGdOCngLe7ACL/
fFCcOQWFOSuBlaBelgqohsJrs1aXlr8W0oDSpCQGLUSVEg4fnhmwl8UdnyA1MXFo
44FdbtQCHCSxyGTZXqG3771sYcPA7jh2QagoPa0NyfHv4ThoOujsgmu/wgKxJ2tG
YlPQvIdrvv0TpMHhJqQti03NLaTndVROPAXKZIs0MNpUp7JhVe8HYGiVSaUOrAuP
a9DMmB7ZJTY+ySkG5vHf1TZi1nMEInz2quWWWqu4tYKUh1mMxGPdbvwxv67qsiSI
Rm8ySED3wIYs4B8j0OyiJBXS8MVBbHd4KOUaemgEvgL27hm8GzS9kzZeapDuCSAJ
X+9YwDuFtMmIC/9qN8rS
=oyIx
-----END PGP SIGNATURE-----

--Sx4srNpQJPWxv35pE5fBEs0ieHw4SHeLH--

