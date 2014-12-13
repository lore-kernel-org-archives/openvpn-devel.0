Message-ID: <548C9667.2070100@...1856...>
Date: Sat, 13 Dec 2014 20:41:27 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <546BCC47.5010205@...68...> <548C93A3.1050807@...68...>
In-Reply-To: <548C93A3.1050807@...68...>
Subject: Re: [Openvpn-devel] AES-NI trouble,
	and patch - please review/comment
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

On 13-12-14 20:29, Matthias Andree wrote:
> Am 18.11.2014 um 23:46 schrieb Matthias Andree:
>> Greetings,
>>
>> I received a bug report against the FreeBSD OpenVPN port, but before
>> applying a patch (by Ermal Lu=E7i) I do not currently oversee, I would
>> like your input.
>>
>> https://redmine.pfsense.org/issues/3966			 original
>> https://community.openvpn.net/openvpn/ticket/480	 copy
>> https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=3D195004 downstream
>>
>> Is this a safe fix, or will it break other features or requirements, in
>> the lights of restarts after timeouts, and all that?
>=20
> Anyone got opinions on this?

I too find it hard to oversee the full consequences of this init order
change. I *think* it is okay after looking through the code, but I did
not yet find time to dig a bit deeper. See also my comment with
questions for the patch author on the trac ticket:
http://community.openvpn.net/openvpn/ticket/480#comment:3

-Steffan

