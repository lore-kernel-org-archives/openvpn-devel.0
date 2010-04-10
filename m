MIME-Version: 1.0
In-Reply-To: <p2w9e0cf0bf1004100005u819d4b3l97c269272e2604ab@...278...>
References: <1269951178-30419-1-git-send-email-dazo@...384...>
	<4BBE3205.1040303@...1114...>
	<p2w9e0cf0bf1004100005u819d4b3l97c269272e2604ab@...278...>
Date: Sat, 10 Apr 2010 10:35:54 +0300
Message-ID: <h2z9e0cf0bf1004100035rc34e5c17rb7cb8554ba64509@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Add comile time settings from
	./configure information to --version
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

Also there is no proper dependency for configure.h in Makefile.am so
it won't be built.
Proper way to do so is like I done for OpenSC [1], look for OPENSC_FEATURES.

[1] http://www.opensc-project.org/opensc/browser/trunk/configure.ac#L613

On Sat, Apr 10, 2010 at 10:05 AM, Alon Bar-Lev <alon.barlev@...277...> wrot=
e:
> Highly none standard autotools usage.
> Also requires awk which may not be available.
> Please REVERT.
>
> On Thu, Apr 8, 2010 at 10:44 PM, David Sommerseth
> <openvpn.list@...1114...> wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 30/03/10 14:12, David Sommerseth wrote:
>>> This patch will create ./configure.h which will contain two new #define
>>> strings. =C2=A0CONFIGURE_DEFINES will contain all USE, ENABLED, DISABLE=
D and
>>> DEPRECATED defines from ./config.h. =C2=A0CONFIGURE_CALL will contain t=
he
>>> complete ./configure line which was used when configuring the package
>>> for building.
>>>
>>> Signed-off-by: David Sommerseth <dazo@...384...>
>>> ---
>>> =C2=A0Makefile.am =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A07 +++++++
>>> =C2=A0configure_h.awk =C2=A0 | =C2=A0 39 ++++++++++++++++++++++++++++++=
+++++++++
>>> =C2=A0configure_log.awk | =C2=A0 36 ++++++++++++++++++++++++++++++++++++
>>> =C2=A0options.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A03 +++
>>> =C2=A04 files changed, 85 insertions(+), 0 deletions(-)
>>> =C2=A0create mode 100644 configure_h.awk
>>> =C2=A0create mode 100644 configure_log.awk
>>
>> Applied to the openvpn-testing.git feat_misc branch. =C2=A0To be merged =
into
>> allmerged soon.
>> Commit f27bf509315a48b0070294c3993a718df0c2626c
>>
>>
>> kind regards,
>>
>> David Sommerseth
>> -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v1.4.10 (GNU/Linux)
>> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>>
>> iEYEARECAAYFAku+MgUACgkQDC186MBRfrrSTQCfZcZ1BbzdmGO7GwKhwMRyYfd3
>> f90AnieGGtEskxG+E5Ng/AxjwnL++6k6
>> =3DqKP1
>> -----END PGP SIGNATURE-----
>>
>> ------------------------------------------------------------------------=
------
>> Download Intel&#174; Parallel Studio Eval
>> Try the new software tools for yourself. Speed compiling, find bugs
>> proactively, and fine-tune applications for parallel performance.
>> See why Intel Parallel Studio got high marks during beta.
>> http://p.sf.net/sfu/intel-sw-dev
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>

