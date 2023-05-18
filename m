Message-ID: <f1428331-1d68-aafc-ba18-e7ce96ba363c@...68...>
Date: Thu, 18 May 2023 09:00:26 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230517200143.216-1-chipitsine@...277...>
 <a362a6e5-c80b-1473-d503-4e51befd22ee@...2181...>
From: Matthias Andree <matthias.andree@...68...>
In-Reply-To: <a362a6e5-c80b-1473-d503-4e51befd22ee@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] src/openvpn/dco_freebsd.c: handle
 malloc failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Am 17.05.23 um 22:47 schrieb Antonio Quartulli:
> Hi,
>
> On 17/05/2023 22:01, Ilya Shipitsin wrote:
>> malloc was not checked against NULL, I was able
>> to get core dump in case of failure
>>
>> Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
>> ---
>> =C2=A0 src/openvpn/dco_freebsd.c | 5 +++++
>> =C2=A0 1 file changed, 5 insertions(+)
>>
>> diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
>> index 1111abeb..adbd1120 100644
>> --- a/src/openvpn/dco_freebsd.c
>> +++ b/src/openvpn/dco_freebsd.c
>> @@ -594,6 +594,11 @@ dco_available(int msglevel)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf =3D malloc(ifcr.ifcr_total * I=
FNAMSIZ);
>> +=C2=A0=C2=A0=C2=A0 if (buf =3D=3D NULL)
>
> as style guideline, we wanted to go for if (!A) rather than if (A =3D=3D
> NULL). Although I am not sure if the whole codebase was cleaned up yet
> or not.

That, and constants usually go on the left-hand side of comparison so
the compiler flags the accidental if (foo =3D NULL) even if it does not
produce "add a pair of parentheses if you really mean to use an
assignment as if() expression" like warnings. You can't if (NULL =3D foo)...

And in practice, if anyone hits C++ some day, it might make a difference
if you're in boolean or pointer contexts, so use if (!A).



