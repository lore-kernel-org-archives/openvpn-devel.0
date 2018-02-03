MIME-Version: 1.0
In-Reply-To: <790b8000-7e9b-4c7a-f2a6-8a600055a590@...2080...>
References: <CAKuzo_jVbyE3kQkgT1aYgMSK-YGm2Ho=Evbsrck5Y4mNwAsKmQ@...278...>
 <6beb138f-831e-edd7-d4dd-28beeadc5310@...515...>
 <790b8000-7e9b-4c7a-f2a6-8a600055a590@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 2 Feb 2018 23:23:17 -0500
Message-ID: <CAKuzo_jJSyPDTsV+YYKXLmTBkY2hFpAySXrcUKFOX64sXuWR4g@...278...>
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Cc: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>, "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>

Hi,

On Fri, Feb 2, 2018 at 8:32 PM, David Sommerseth
<openvpn@...2080...> wrote:
> On 30/01/18 10:33, Samuli Sepp=C3=A4nen wrote:
>> Hi,
>>
>> Il 29/01/2018 20:09, Selva Nair ha scritto:
>>> (Cross posting to users and devel)
>>>
>>> Hi,
>>>
>>> 2.4.x needs to support, Vista, isn't it?
>>
>> Good question and we have discussed in the past. Windows Vista is no
>> longer supported by Microsoft:
>>
>> <https://support.microsoft.com/en-us/help/13853/windows-lifecycle-fact-s=
heet>
>>
>> But then again, we do provide installers which work on Windows XP, which
>> is similarly EOL. So I guess we do support Windows Vista for the time be=
ing.
> <https://community.openvpn.net/openvpn/wiki/SupportedVersions#SupportedWi=
ndowsversions>
>
> Vista is currently in full support for 2.4.4.  WinXP is being phased out =
when
> 2.3 hits "Old stable support".  But we can certainly discuss the value of
> supporting Vista when Microsoft does not officially support it.  I'd be in
> favour of supporting only Win7 and newer.
>

+1 for dropping Vista support. Unlike XP, the releases will continue
to work on Vista until we start using some exclusively Win7+ API, but
we just stop
guaranteeing Vista compatibility beyond, say, 2.4.6.

It seems no one here has access to Vista and we'll soon start shipping
binaries untested on Vista.

Selva

