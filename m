From: Jeremie Courreges-Anglas <jca@...2272...>
References: <1520185442-22901-1-git-send-email-selva.nair@...277...>
 <87efkz7k42.fsf@...2274...>
 <CAKuzo_jGB0mHc7kKu-pdzTEt3FZst75PL6GKy73A6_eakRh6dw@...278...>
Date: Mon, 05 Mar 2018 00:13:48 +0100
Message-ID: <87sh9fzb6b.fsf@...2274...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH] Do not assume that
 SSL_CTX_get/set_min/max_proto_version are macros
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 04 2018, Selva Nair <selva.nair@...277...> wrote:
> Hi,
>
> On Sun, Mar 4, 2018 at 1:48 PM, Jeremie Courreges-Anglas <jca@...2272...>=
 wrote:
>> On Sun, Mar 04 2018, selva.nair@...277... wrote:
>>> From: Selva Nair <selva.nair@...277...>
>>>
>>> Openssl docs do not explicitly state these to be macros although they
>>> are currently defined as such.
>>
>> Actually they are documented as macros by OpenSSL since day 1, see
>> NOTES.
>
> You are right, I missed that in the docs. In that case my patch is not
> needed especially so if libressl will provide those macros.

It all depends if you want to support LibreSSL 2.6.x installations, as
I'm not sure I'll be able to backport this in the 2.6 branch (which
is supposed to receive security/reliability fixes only).

> I'm still concerned about set and get functions coming from different
> sources

Indeed.  A diff is floating to also add the getters to LibreSSL,
hopefully this will make it in the upcoming 2.7.x release.

> and may be we should fix that by requiring that if set is
> defined we need get too. But that will once again break libressl
> compatibility.
--=-=-=--
