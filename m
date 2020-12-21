References: <20201220105430.GP976@...1296...>
 <CACDCbPrvwmEGyAt1C4pVmzmCi0p-7nWkBqmDgDZAR00Bw6S8Zg@...278...>
 <CAFHpkQG+vH5LfZXfN0Zs2PVaW1_40tjuFD8ObF7FhBCyXV_JtQ@...278...>
 <CACDCbPprxYNcNhrPufPSZ6tU_7fFmWUP7wNPuzz_0EfGzWDCHA@...278...>
 <20201221191127.GB976@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <96b776cd-6ed9-a310-523f-b78497f4a38f@...1227...>
Date: Mon, 21 Dec 2020 21:25:43 +0100
MIME-Version: 1.0
In-Reply-To: <20201221191127.GB976@...1296...>
Content-Language: en-GB
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
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Greg Cox <gcox@...1057...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 21.12.20 um 20:11 schrieb Gert Doering:
> Hi,
> 
> On Mon, Dec 21, 2020 at 06:24:36PM +0000, Greg Cox wrote:
>> My contention is, a VPN client has enough information from its own certs to
>> know when its certs are expired and thus not going to work (Yes, there's
>> plenty of OTHER reasons a connection can fail, but in a well designed
>> setup, the user's certs will go stale long before the server).  It tells
>> you this problem in the logs, which folks never read.  
> 
> We consciously decided to make this not more prominent (so, warning only,
> not error) because the client's machine's time might be wrong - and 
> ultimately it's the server's notion of time that decides if the cert
> is valid or not.  So this is a hint, but not a "IT WILL NOT WORK!" hard
> error.
> 
>> If the software were
>> to contain a mechanism to make certain failure cases automatically more
>> prominent, particularly for 'simple' users who have GUI clients, it'll be a
>> big win for supportability on larger installs.
> 
> This is indeed getting into philosophy... we do send different types of
> AUTH_FAILED today (like, for token expired).  Maybe we could send an
> "AUTH_FAILED,cert expired" and have the client display this?
> 
> (I admit that I'm neither an expert on AUTH_FAILED message, nor on
> "what is the client doing on variations of it", nor on "what *should*
> be the expected outcome?".  Selva, Arne will know more).

It is easy to add that message, however the question is if we want to.
Sending different AUTH_FAILED message also leaks information. Especially
with authentication you don't want to give an attacker an idea how they
get before failing the authentication. I.e. if you send User disable,
certificate expired, account not allow to use VPN etc. an attacker gets
information about the account/profile he using to connect.

So with these AUTH_FAILED codes you have to be very careful not to
accidently leak information. I.e. AUTH_FAILED, cert expired happens only
if user/pass is right/wrong, otherwise you get a normal AUTH_FAILED.

HOWEVER, on the client side. We can transform a normal AUTH_FAILED into
an AUTH_FAILED, server gave no reason, [client certificate is expired]
or something like that.

Arne

