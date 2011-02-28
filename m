Message-ID: <4D6BAFDC.7040307@...1449...>
Date: Mon, 28 Feb 2011 15:23:24 +0100
From: Stefan Hellermann <stefan@...1449...>
MIME-Version: 1.0
References: <4D6ABF00.8070309@...1449...> <4D6B580C.4030606@...515...>
In-Reply-To: <4D6B580C.4030606@...515...>
Subject: Re: [Openvpn-devel] [PATCH] plugin.h: update prototype of
 plugin_call dummy in !ENABLE_PLUGIN case
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 28.02.2011 09:08, schrieb Samuli Sepp=E4nen:
>=20
>> plugin.h: update prototype of plugin_call dummy in !ENABLE_PLUGIN case
>>
>> Commit 2db5a0ac3e053857d97e468de53e70a605f54561 adds two arguments to
>> plugin_call(...), but missed the !ENABLE_PLUGIN case. With
>> !ENABLE_PLUGIN, plugin_call(...) is only a dummy, so add these two
>> parameters there too.
>>
>> ---
>>  plugin.h |    4 +++-
>>  1 files changed, 3 insertions(+), 1 deletions(-)
>>
>> This is my first patch with git, is everything correct? This patch is
>> against the allmerged branch.
>>
>>  =20
> Hi Stefan,
>=20
> I think you should rebase your patch against the "beta2.2" branch. No
> development is done in the "allmerged" branch, it only used to aggregate
> code from other branches.
>=20
The commit which introduces this build-failure is in the bugfix2.1
branch. Could you apply it there and merge the patch to allmerged?

Otherwise the weekly snapshots linked on
https://community.openvpn.net/openvpn/wiki/TesterDocumentation
do not build in the !ENABLE_PLUGIN case.

The router distribution Openwrt is using these.

Regards,
Stefan

