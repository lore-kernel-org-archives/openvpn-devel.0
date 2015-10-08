MIME-Version: 1.0
In-Reply-To: <20151008081119.GW22054@...1296...>
References: <1444156707-14087-1-git-send-email-steffan@...1856...>
	<20151008064333.GR22054@...1296...> <56161D90.7040101@...1227...>
	<20151008081119.GW22054@...1296...>
From: Steffan Karger <steffan@...1856...>
Date: Thu, 8 Oct 2015 13:55:31 +0200
Message-ID: <CAA1Abx+Cad6b42JHCA-MA1XW_6JBmQCOdUDUxU_1Kyz+H0nE3A@...278...>
Subject: Re: [Openvpn-devel] [PATCH] openssl: be less verbose about cipher
 translation errors
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Thu, Oct 8, 2015 at 10:11 AM, Gert Doering <gert@...1296...> wrote:
> On Thu, Oct 08, 2015 at 09:38:56AM +0200, Arne Schwabe wrote:
>> Am 08.10.15 um 08:43 schrieb Gert Doering:
>> > On Tue, Oct 06, 2015 at 08:38:27PM +0200, Steffan Karger wrote:
>> >> Translation errors are usually not a real problem, since we don't maintain
>> >> the complete list of ciphers OpenSSL supports.  So, be less verbose if we
>> >> can not find a translation.
>> >
>> > I wonder what the motivation on this one is.  If the user requests a
>> > certain cipher, and we can't give it to him - shouldn't this be warned
>> > about quite prominently?
>>
>> The user request a cipher that exists, but is not our translation table.
>> Gets a confusion error message.
>
> But what happens in that case?  PolarSSL build, user requests something
> he knows from OpenSSL, we don't have a translation entry for it - will
> he receive "the default cipher set" (not what he is asking for) then?

What our translation does is "if we know a translation for a cipher,
then replace with translation, else warn and leave original". The
resulting cipher string is then passed to the crypto library.  The
crypto library will then either connect or give a (sometimes cryptic)
error.  We do this, because we simply can't keep track of all (new, or
just exotic) cipher names, but do want to offer config compatibility
for most standard setups between polar<>openssl.

However, as Arne said, the current warning about cipher translations
often puts users on the wrong track when debugging connection
problems.  (Although that usually just means they should no use
--tls-cipher...)  So, add some commonly used negated ciphers and hide
the (often innocent) warning a bit more.

-Steffan

