MIME-Version: 1.0
In-Reply-To: <4ED8C6B0.2000609@...1114...>
References: <1322823734-17993-1-git-send-email-davids@...1347...>
	<CAOazyz0=n=7w6d-k3rcwBOsEJ+35aDLwZ8uPugPb8_b2QbgM6g@...278...>
	<4ED8C6B0.2000609@...1114...>
Date: Fri, 2 Dec 2011 14:45:11 +0200
Message-ID: <CAOazyz0-vG8JHNa-MxvSSnsUScmRncBQXU6Gq_2RWnLi8QoPzQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, Dec 2, 2011 at 2:38 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 02/12/11 13:28, Alon Bar-Lev wrote:
>> I think the whole code should be more autoconf depended. Autoconf can
>> detect if POSIX version is available and if not, code can provide
>> alternative. No need for the openvpn_ functions and wrappers.
>
> Fair enough statement, but we have a python oriented build environment on
> Windows too, which will not be so easy to tackle in this regards. =C2=A0T=
his
> environment is required by OpenVPN Technologies for their internal build
> farms (most likely for the OpenVPN Access Server product).
>

It is not matter if you use python for Windows, as you create
config-msvc.h with all constants that autoconf would have found.

Alon.

