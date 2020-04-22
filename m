References: <2b5fbffa-6b18-2226-5b29-7c6be670413b@...1800...>
 <20200421183735.GB1431@...1296...> <20200421185953.GC1431@...1296...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <59fc004a-b2d7-3f7a-6f61-683acd04215e@...1147...>
Date: Wed, 22 Apr 2020 09:09:02 +0200
MIME-Version: 1.0
In-Reply-To: <20200421185953.GC1431@...1296...>
Content-Language: nl-NL
Subject: Re: [Openvpn-devel] [Openvpn-users] new openssl = new OpenVPN
 release ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, mike tancsa <mike@...1800...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Hi Gert,

On 21/04/20 20:59, Gert Doering wrote:
> Hi,
>
> On Tue, Apr 21, 2020 at 08:37:35PM +0200, Gert Doering wrote:
>> On Tue, Apr 21, 2020 at 02:15:43PM -0400, mike tancsa wrote:
>>>  =A0=A0=A0 Will the sec issue with OpenSSL force a new release of OpenV=
PN ?
>>>
>>> https://www.openssl.org/news/secadv/20200421.txt
> So, speaking to myself again :-) - I've looked at the advisory, and
> it talks about "Server or client applications that call the
> SSL_check_chain() function".
>
> Which we don't, I just grepped through our source tree.
>
> So, unless I misunderstand something about OpenSSL intricacies, I think
> we're safe - no new installers needed, and OpenVPN is not in risk.
>
>
the advisory applies only to application that use the SSL_check_chain()=20
function as part of a TLS 1.3 handshake. AFAIK, iIn OpenVPN 2.4 we don't=20
do anything with TLS 1.3 just yet, so this security advisory does not=20
apply to OpenVPN. Also note that this bug appears only in OpenSSL 1.1.1=20
[d-f] , so anything older is fine as well.

cheers,

JJK


