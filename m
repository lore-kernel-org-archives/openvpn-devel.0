MIME-Version: 1.0
In-Reply-To: <20171120080604.GX958@...1296...>
References: <20171112163636.17434-1-steffan@...1856...>
 <201711192037.vAJKbuHH080370@...2054...>
 <20171119213837.GA80839@...1296...> <8760a6kjwc.fsf@...2274...>
 <20171120080604.GX958@...1296...>
From: Steffan Karger <steffan@...1856...>
Date: Mon, 20 Nov 2017 10:51:41 +0100
Message-ID: <CAA1Abx+NCXkP_Ns03AzgUt+-W8VPmpYmrptkiohbzO6rZ7Gj-w@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add --tls-cert-profile
 option for mbedtls builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: Steffan Karger <steffan.karger@...1435...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 20-11-17 09:06, Gert Doering wrote:> On Sun, Nov 19, 2017 at
11:01:39PM +0100, Jeremie Courreges-Anglas
> wrote:
>>> (Not sure, though, why it only complains about two out of
>>> three, but still annoyance...  if LibreSSL claims
>>> OPENSSL_VERSION_NUMBER >= 0x10100000 it better should provide
>>> everything needed)
>>
>> LibreSSL defines:
>>
>> #define OPENSSL_VERSION_NUMBER        0x20000000L
>>
>> breaking #ifdef checks based on it.
>
> Indeed.  I find this a curious and not useful setting - "if it's
> not compatible with OPENSSL, why define such a version number"?
> But that's slightly out of scope here...

+1, highly frustrating.  LibreSSL should really just make up their
mind whether they want to be OpenSSL-compatible or not, and act
accordingly.

>> Sadly, people tend to prefer adding
>>
>> && !defined(LIBRESSL_VERSION_NUMBER)
>>
>> to fix the build, rather than doing features detection using
>> autoconf or similar.  openvpn can easily solve this.
>
> ... and I'm thankful for your patch, because this is exactly what I
>  considered doing here.  We already check for all the 1.0/1.1
> openssl differences (accessor functions), so adding this one is
> logical.

*If* we want to keep LibreSSL working, I agree this is the way to go.
 But I'm kind of annoyed that we are including more and more #ifdefs
to keep LibreSSL happy.  The version checks are much simpler and make
it easy to see what code can be purged when we drop support for e.g
openssl 1.0.1.  I don't want to keep these 'backwards compatibility'
ifdefs forever.  At some point we'll have to decide to either
completely stop supporting LibreSSL, or add it as a true abstraction
(which I will *not* maintain).  We're getting closer and closer to
that point.

>>> This is on OpenBSD 6.0, which happens to be something Samuli's
>>> vagrant setup can provide nicely if anyone wants to have a look
>>> :-)
>>
>> Here's a diff, master builds and seems to run fine as a client
>> on OpenBSD-current.
>
> Thanks.  Patch looks good to me, but I leave the final word to
> Steffan (maybe he wants to amend the non-support message to include
> LibreSSL, or whatever)

They look good at first sight, but I'll check these properly later
this week - when I have some spare cycles available.

>> I can cook a similar diff for the remaining OPENSSL /
>> LIBRESSL_VERSION_NUMBER #ifdef.
>
> This would be appreciated.

Same reservations as above.

To reiterate: our policy towards LibreSSL is currently that we do
*not* support it, but we won't break it on purpose and accept trivial
patches to keep it working.  Where 'trivial' is - of course - fuzzy.

-Steffan

