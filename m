Message-ID: <4ED8D117.7080904@...1114...>
Date: Fri, 02 Dec 2011 14:22:31 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1322823734-17993-1-git-send-email-davids@...1347...>
	<CAOazyz0=n=7w6d-k3rcwBOsEJ+35aDLwZ8uPugPb8_b2QbgM6g@...278...>
	<4ED8C6B0.2000609@...1114...>
	<CAOazyz0-vG8JHNa-MxvSSnsUScmRncBQXU6Gq_2RWnLi8QoPzQ@...278...>
In-Reply-To: <CAOazyz0-vG8JHNa-MxvSSnsUScmRncBQXU6Gq_2RWnLi8QoPzQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Windows does not have dirname() -
 reimplement a portable version
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/12/11 13:45, Alon Bar-Lev wrote:
> On Fri, Dec 2, 2011 at 2:38 PM, David Sommerseth 
> <openvpn.list@...1114...> wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> On 02/12/11 13:28, Alon Bar-Lev wrote:
>>> I think the whole code should be more autoconf depended. Autoconf
>>> can detect if POSIX version is available and if not, code can
>>> provide alternative. No need for the openvpn_ functions and
>>> wrappers.
>> 
>> Fair enough statement, but we have a python oriented build
>> environment on Windows too, which will not be so easy to tackle in
>> this regards.  This environment is required by OpenVPN Technologies
>> for their internal build farms (most likely for the OpenVPN Access
>> Server product).
>> 
> 
> It is not matter if you use python for Windows, as you create 
> config-msvc.h with all constants that autoconf would have found.

Fair enough.  I'll give that a poke and come up with new patches.


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7Y0RUACgkQDC186MBRfrqiJgCfcpObXpcbhHzhgMVYvqMbwdo7
ExoAn3W3cB8zU4rQtl7DV1DdK2XjRXO7
=n594
-----END PGP SIGNATURE-----

