References: <20201220105430.GP976@...1296...>
 <CACDCbPrvwmEGyAt1C4pVmzmCi0p-7nWkBqmDgDZAR00Bw6S8Zg@...278...>
 <CAFHpkQG+vH5LfZXfN0Zs2PVaW1_40tjuFD8ObF7FhBCyXV_JtQ@...278...>
 <CACDCbPprxYNcNhrPufPSZ6tU_7fFmWUP7wNPuzz_0EfGzWDCHA@...278...>
 <20201221191127.GB976@...1296...>
 <96b776cd-6ed9-a310-523f-b78497f4a38f@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <eeec7102-1b2a-a2cf-001a-56cfb698eafa@...1856...>
Date: Tue, 22 Dec 2020 19:20:00 +0100
MIME-Version: 1.0
In-Reply-To: <96b776cd-6ed9-a310-523f-b78497f4a38f@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] wanted: mechanism to send text messages to
 client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 21-12-2020 21:25, Arne Schwabe wrote:
> Am 21.12.20 um 20:11 schrieb Gert Doering:
>> On Mon, Dec 21, 2020 at 06:24:36PM +0000, Greg Cox wrote:
>>> If the software were
>>> to contain a mechanism to make certain failure cases automatically more
>>> prominent, particularly for 'simple' users who have GUI clients, it'll be a
>>> big win for supportability on larger installs.
>>
>> This is indeed getting into philosophy... we do send different types of
>> AUTH_FAILED today (like, for token expired).  Maybe we could send an
>> "AUTH_FAILED,cert expired" and have the client display this?
>>
>> (I admit that I'm neither an expert on AUTH_FAILED message, nor on
>> "what is the client doing on variations of it", nor on "what *should*
>> be the expected outcome?".  Selva, Arne will know more).
> 
> It is easy to add that message, [...]

Uhm, I would say it's impossible to send that message. AUTH_FAILED
messages are sent over the control channel, while in case of certificate
errors the control channel will never be initialized.

We could however do something that has the same effect: don't prevent
TLS from sending it's "certificate_expired" alert. OpenVPN 2 (don't know
about 3) currently just doesn't respond at all if it detects a TLS error.

IIRC, this extra-paranoid behaviour has saved us from at least one of
the timing-based attacks on TLS from the past, but I can't recall which one.

At the same time, the TLS protocol and it's implementation have matured
a lot since heartbleed. Possibly beyond the point where usability
concerns now outweigh the security concerns. Before anyone suggests
making this optional: no. no. no. I strongly believer we should
carefully consider if we want to allow TLS to send alerts, or leave this
as-is.

David actually already brought this up in 2016, see this thread:
https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12892.html

Note that any of this is separate from the initial discussion, where
Gert proposes to send notifications *before* the certificate expires.

-Steffan

