References: <99D61A626FDA8A4B90A270669121BE108587171C@...2294...>
 <CAKuzo_her_KFBMA3Xt6zKGmHGLnc89qXkb=n_LnvxcSzsvdV+A@...278...>
 <99D61A626FDA8A4B90A270669121BE1085875356@...2294...>
 <CAKuzo_hpGEdV8fqTjRYWqPnb8b15JKmng_KrazQOPq6Kaq9qSQ@...278...>
 <99D61A626FDA8A4B90A270669121BE1085876852@...2294...>
 <023dbb4e-47b6-bceb-8913-40d5bf4ae76e@...515...>
 <99D61A626FDA8A4B90A270669121BE1085877307@...2294...>
 <031e4c73-3317-585d-38af-30ac9fede8ff@...515...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <d6b130c0-96a3-830f-7e80-bbe7b1f055a0@...1856...>
Date: Thu, 2 Nov 2017 09:41:21 +0100
MIME-Version: 1.0
In-Reply-To: <031e4c73-3317-585d-38af-30ac9fede8ff@...515...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] OpenVPN Interactive Service Branding
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 02-11-17 09:31, Samuli Seppänen wrote:
> On 01/11/2017 20:46, Simon Rozman wrote:
>>> Speaking of MSIs... we are planning on moving from NSIS to MSI due to
>>> security issues like the one we fixed in previous release. At the moment four
>>> (other) people who have expressed interest in taking part in the "create MSI
>>> installers for OpenVPN" project. One of these people is me.
>>>
>>> Would you be interested in joining forces in this task?
>>
>> I'd love to. Count me in!
> 
> Excellent!
> 
>> I have been in the MSI packaging for about 10 years now - automated builds from command line, developed DLL custom actions in C/C++, localization, GUI, WiX etc.
> 
> As you probably know, right now we produce Windows executables and
> installers on Linux using openvpn-build:
> 
> <https://github.com/OpenVPN/openvpn-build>
> 
> It seems that WiX which you mention would probably be our tool of
> choice, given it is open source (MS-RL):
> 
> <https://github.com/wixtoolset/wix3>
> <https://opensource.org/licenses/MS-RL>
> 
> Do you know if WiX runs in Mono? That would allow us to produce
> installers directly from openvpn-build without having to have a separate
> Windows packaging computer in the build chain.
> 

Any reason why you specifically want to use WiX?  Are msibuild or wixl
(from msitools[0]) not good enough?  I know those lack features, but if
they're good enough I would prefer using something that is packaged by
many distros (and doesn't need mono).

-Steffan

[0] https://wiki.gnome.org/msitools

