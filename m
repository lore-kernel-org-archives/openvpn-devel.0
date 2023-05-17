From: Kristof Provost <kp@...1376...>
Date: Wed, 17 May 2023 17:10:09 -0400
Message-ID: <4C50099D-11A0-4BE2-8E88-8E9C1327519B@...1376...>
In-Reply-To: <CAFHpkQFUYAbi=XPer39VshqN=Qcbcatcg1FGLpLHmxcKYKKDRA@...278...>
References: <20230517200143.216-1-chipitsine@...277...>
 <02835E0F-FA73-4722-83EB-17A33A3A8DA5@...1376...>
 <CAFHpkQER6g7MPu07_0TbKnnvc6poGsD2nZqLyATFXQN4JwiseQ@...278...>
 <DEA80ADA-574E-431E-A61E-89F4840AD9AF@...1376...>
 <CAFHpkQFUYAbi=XPer39VshqN=Qcbcatcg1FGLpLHmxcKYKKDRA@...278...>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?utf-8?b?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On 17 May 2023, at 17:06, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD wrote:
> =D1=81=D1=80, 17 =D0=BC=D0=B0=D1=8F 2023=E2=80=AF=D0=B3. =D0=B2 23:04, Kr=
istof Provost <kp@...1249...>:
>
>> On 17 May 2023, at 16:58, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD wrote:
>>> =D1=81=D1=80, 17 =D0=BC=D0=B0=D1=8F 2023=E2=80=AF=D0=B3. =D0=B2 22:43, =
Kristof Provost <kp@...1249...>:
>>>
>>>> On 17 May 2023, at 16:01, Ilya Shipitsin wrote:
>>>>> malloc was not checked against NULL, I was able
>>>>> to get core dump in case of failure
>>>>>
>>>>> Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
>>>>> ---
>>>>>  src/openvpn/dco_freebsd.c | 5 +++++
>>>>>  1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
>>>>> index 1111abeb..adbd1120 100644
>>>>> --- a/src/openvpn/dco_freebsd.c
>>>>> +++ b/src/openvpn/dco_freebsd.c
>>>>> @@ -594,6 +594,11 @@ dco_available(int msglevel)
>>>>>      }
>>>>>
>>>>>      buf =3D malloc(ifcr.ifcr_total * IFNAMSIZ);
>>>>> +    if (buf =3D=3D NULL)
>>>>> +    {
>>>>
>>>> I=E2=80=99d =E2=80=98goto out;=E2=80=99 instead, because that=E2=80=99=
s how we handle other errors in
>> this
>>>> function.
>>>> (free(NULL) is guaranteed to be safe, so we can just do that.)
>>>>
>>>
>>> on "goto out" we'll end with "return available;"
>>>
>> =E2=80=98available=E2=80=99 defaults to =E2=80=98false=E2=80=99, so that=
 seems fine to me.
>>
>
> looks fragile :)
>
> I do not see benefits of such an approach. But it will work indeed
>
The reasoning is that it keeps the error handing consistent. If we ever ext=
end the function to e.g. open another file descriptor we=E2=80=99d only hav=
e to change the error handling in one location.

We=E2=80=99re not adding new ways for the function to fail either. The next=
 potential error is the ioctl() call, where we do exactly the same thing (i=
.e. goto out) on error, so it already relies on available being set to fals=
e.

Best regards,
Kristof

