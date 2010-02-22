Message-ID: <4B82366D.4080405@...1114...>
Date: Mon, 22 Feb 2010 08:46:53 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1266637180.23846.1@...1207...>
In-Reply-To: <1266637180.23846.1@...1207...>
Subject: Re: [Openvpn-devel] [PATCH v2] Do not randomize resolving of IP
 addresses in getaddr()
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
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 20/02/10 04:39, Karl O. Pinc wrote:
> On 02/19/2010 05:11:38 PM, David Sommerseth wrote:
>> On 20/02/10 00:06, Karl O. Pinc wrote:
>>> On 02/19/2010 04:57:30 PM, David Sommerseth wrote:
>>>
>>> Am I wrong or does using --disable-depr-random-resolv
>>> not remove the random choice?
>>
>> That is correct.  According to the newly agreed feature removal
>> process,
>> deprecated features should in the beginning be enabled but give
>> warnings
>> when they are triggered.  At some point, this behaviour will be
>> switched
>> to be disabled, and you need to do use --enable-depr-random-resolv.
>> And if nobody complains in the end, this code will be removed
>> completely.
> 
> I understand the point of the policy, but it seems a bit crazy
> to ask for the feature to be disabled and have it _not_ be disabled
> but to get a warning instead.  
> 
> What you have right now is (unless I mis-understand the code):
> 
> Regardless of whether you ask for the feature to be disabled
> or not the feature remains _enabled_ and you get a
> runtime warning.
> 
> If you ask for the feature to be enabled you get no warning.
> 
> 
> What makes sense to me is:
> 
> By default the feature remains enabled but there _is_ a 
> runtime warning.
> 
> If you explicitly ask for the feature to be disabled then it
> is disabled and there is _no_ runtime warning.
> 
> If you explicitly ask for the feature to be enabled then
> it is enabled and there is _no_ runtime warning.

You are right, that was badly worded from my side.  I will correct that
when I implement the patch into the testing tree.  The commit log will
state that this begins the feature deprecation process, with a warning
when this feature is used and the feature can be removed at compile time
with --disable-depr-random-resolv.

- --
kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuCNmkACgkQDC186MBRfrqtbACfSu+hFWOI8dvMpZGs1s2RilfD
HsgAnieBeWZLf924/IZxeLme+kR03vqG
=2sDe
-----END PGP SIGNATURE-----

