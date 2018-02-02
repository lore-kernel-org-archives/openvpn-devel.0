MIME-Version: 1.0
In-Reply-To: <6beb138f-831e-edd7-d4dd-28beeadc5310@...515...>
References: <CAKuzo_jVbyE3kQkgT1aYgMSK-YGm2Ho=Evbsrck5Y4mNwAsKmQ@...278...>
 <6beb138f-831e-edd7-d4dd-28beeadc5310@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 2 Feb 2018 10:09:01 -0500
Message-ID: <CAKuzo_j1mB-1mtck09u1dB3P3a0XL0zwNGNoZMhc1ZZ5B4sa8g@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] test latest binary on vista
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
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Tue, Jan 30, 2018 at 4:33 AM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:
> Hi,
>
> Il 29/01/2018 20:09, Selva Nair ha scritto:
>> (Cross posting to users and devel)
>>
>> Hi,
>>
>> 2.4.x needs to support, Vista, isn't it?
>
> Good question and we have discussed in the past. Windows Vista is no
> longer supported by Microsoft:
>
> <https://support.microsoft.com/en-us/help/13853/windows-lifecycle-fact-sh=
eet>
>
> But then again, we do provide installers which work on Windows XP, which
> is similarly EOL. So I guess we do support Windows Vista for the time bei=
ng.
>
>>
>> Can anyone please latest 2.4 release branch on Windows Vista using an
>> RSA certificate in Windows cert store (using --cryptoapicert option) ?
>>
>> Need to be built with openssl 1.1. Not sure the snapshots are built that=
 way..
>> https://build.openvpn.net/downloads/snapshots/
>
> Not yet. I will switch snapshot builds to OpenSSL 1.1 once
> openvpn-build's openvpn.nsi stops failing on OpenSSL 1.1 libraries
> (names have changed). A PR is pending but it still needs one minor fix.
>
>> The recent changes to cryptoapi uses CNG api which is supposedly
>> supported on Vista but some testing would be useful. I no longer have
>> access to a Vista machine.

FWIW, I did quick test of master (with openssl 1.1) on Windows server
2008 (API version same as vista?). Using cryptoapicert with an EC cert
worked, so hopefully its all good.

By the way, 2.4 with openssl 1.0 and 1.1 should have the same
functionality. Thus testing the current snapshot build (openssl 1.0)
is useful too..

Selva

