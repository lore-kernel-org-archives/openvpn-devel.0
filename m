Message-ID: <4F7DA7EF.1010709@...515...>
Date: Thu, 05 Apr 2012 17:10:55 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] ACK system review finished
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: James Yonan <james@...515...>

Hi all,

As promised I did a brief review of our current ACK system:

<https://community.openvpn.net/openvpn/wiki/ACKSystemReview>

One thing that surprised me was that only on 2 occasions (out of ~60
"real" patches) a patch was modified during the review process. For
comparison, let's look at two big patchsets:

- PolarSSL support [1], ~115 patches
  - total of 8 changes were asked for
  - 3 of these seem trivial stylistic issues/typos

- Buildsystem revolution[2], 52 patches
  - a couple of changes were asked for (e.g. to enable lzo by default)

There seems to be a fair amount of delay from patch introduction to the
commit to Git repo. For individual patches the delay tends to be less
than a week, which I think is ok. For patchsets, the delay is much
longer (15-120 days). It's difficult to say whether we could reduce the
delay with advanced tools... after all, somebody (=3Dhuman) has to review
the patches, whatever tools we use.

Due to a number of factors parsing the raw data was challenging...
unlike I assumed, finding discussions related to the patches was often
surprisingly difficult/impossible, although the "Acked-by" entries in
Git clearly show that an ACK was given at some point. Also, quite a few
patches (~20%) already go in without an ACK.

My personal feeling based is that we should probably focus the ACK
system to high-risk patches, e.g.

- patches touching critical parts of the code (rationale: better safe
than sorry)
- patches from new contributors (rationale: fix stylistic issues and
errors, ensure usefulness, educate)

We might also want to experiment with better tools to see if that speeds
up patch processing... that's definitely an issue with big patchsets.
Merging patches without a formal review might also make sense in some
scenarios, e.g. in low-risk areas which have an active maintainer.

Although the ACK system _does_ catch some problems and is clearly
useful, it also slows down flow of code into Git. This has the
side-effect that new code does not get real-life testing from users as
soon as it could. I think the key is apply each method (push quickly
into testing vs. formal review) where it makes most sense.

Also, one idea would be to review patches _after_ they've been merged to
Git, provided they make sense, i.e. nobody loudly complains about them.
For example, in PolarSSL's case, this would have allowed us to test the
code for ~4 months while the patches were being reviewed.

Anyways, let me know what you think... and please forgive me for not
getting back to this topic before Tuesday... I've been forbidden to work
during Easter by $fiancee :).

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


[1] <https://community.openvpn.net/openvpn/wiki/PolarSSLintegration>
[2]
<https://community.openvpn.net/openvpn/wiki/GenericBuildsystemIntegration#B=
uildrevolutionpatchset>


