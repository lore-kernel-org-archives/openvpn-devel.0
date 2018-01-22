References: <CAKuzo_jF_fHfcEPUXeo6WKWQ4tw7T72-cexEUda=USGd9Ref7g@...278...>
 <e09e95cd-a6d1-e1c0-9c05-738362207278@...2080...>
 <98ce7083179e0a097b35953a9ef3879c.squirrel@...2257...>
 <91ffd543-3f5a-e08d-ac89-379770b46b96@...2080...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <1f480b84-a0f8-a0a0-7bf7-0081e44d1c06@...1435...>
Date: Mon, 22 Jan 2018 17:05:35 +0100
MIME-Version: 1.0
In-Reply-To: <91ffd543-3f5a-e08d-ac89-379770b46b96@...2080...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] On testing with openssl 0.9.8
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

Didn't we have this discussion before?  Gert basically NAK'd removing
support for a library version in a dot-release, which I think is valid
reasoning (even though I really would like to drop 0.9.8).

Anyway, to fill in the facts:

On 22-01-18 15:55, David Sommerseth wrote:
> On 22/01/18 15:12, Simon Matter wrote:
>>> On 20/01/18 18:22, Selva Nair wrote:
>>>> Does openvpn-vagrant include any VM provisioning with
>>>> openssl-0.9.8? Until recently I had access to a few old
>>>> debian boxes but now all updated and 0.9.8 testing is getting
>>>> harder.
>>> 
>>> Let me rather twist this question around ... Do we want to
>>> support OpenSSL 0.9.8?  Are there any Linux distributions or
>>> other OSes out there in the wild which is still supported which
>>> are also based on openssl-0.9.8?
>> 
>> If it's possible without too many headaches, I'd appreciate if 
>> openssl-0.9.8 support would be kept in during the 2.4 series.
> 
> Can you elaborate more on your use case?  Keeping something just to
> keep something is kind of a poor argument.  But of course, it goes
> the other way around too, we shouldn't kick it out just to kick it
> out either.
> 
> Currently, I'm mostly concerned that keeping the support span from
> 0.9.8 to 1.1.x can lead to maintenance challenges in the longer run
> - especially if the use cases are poor.
> 
> To me it then gets crucial that users needing openssl-0.9.8 have
> access to a maintained distribution of that particular OpenSSL
> version.  Otherwise, we're deluding OpenVPN users it is safe to use
> openssl-0.9.8.

SLES11 supports 0.9.8 upto 2022:

https://www.suse.com/LinuxPackages/packageRouter.jsp?product=server&version=11&service_pack=&architecture=i386&package_name=openssl

https://www.suse.com/lifecycle/

> So if we don't have really strong arguments keeping support for
> this old version, we should carefully consider our options.

We already removed support for < 1.0.1 in the master branch.  Maybe
just make sure we can get 2.5 out, and move forward that way :)

-Steffan

