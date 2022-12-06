Message-ID: <be6ca0b6-8c90-48a9-2f8a-ef175a824bf4@...1227...>
Date: Wed, 7 Dec 2022 00:26:11 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20221206133647.954724-1-arne@...1227...>
 <202212061554.2B6Fscpj021683@...2054...>
 <Y49rj2dL4+OYvjNO@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <Y49rj2dL4+OYvjNO@...1296...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Fix connection cookie not
 including address and fix endianness in test
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Am 06.12.22 um 17:19 schrieb Gert Doering:
> Hi,
> 
> On Tue, Dec 06, 2022 at 04:54:38PM +0100, Gert Doering wrote:
>> I have not server-tested this, as it "should not" make a difference,
>> and Arne did test this on s390.  The full server tests will run
>> tonight, though.
> 
> I *should* have, as that would have caught the fact that this patch
> breaks pkt_testdriver on Linux, no matter if OpenSSL or mbedTLS
> 
> [ RUN      ] test_calc_session_id_hmac_static
> [  ERROR   ] --- difference at offset 0 0xffffff84 0xffffff8b
> difference at offset 1 0x73 0xffffffeb
> difference at offset 2 0x52 0x3d
> difference at offset 3 0x2b 0x20
> difference at offset 4 0x5b 0x14
> difference at offset 5 0xffffffa9 0x53
> difference at offset 6 0x2a 0xffffffbe
> difference at offset 7 0x70 0x0a
> 8 bytes of 0x7ffe60967bd0 and 0x7ffe60967bc8 differ
> [   LINE   ] --- test_pkt.c:492: error: Failure!
> [  FAILED  ] test_calc_session_id_hmac_static
> ...
> [==========] 9 test(s) run.
> [  PASSED  ] 8 test(s).
> [  FAILED  ] 1 test(s), listed below:
> [  FAILED  ] test_calc_session_id_hmac_static
> 
>   1 FAILED TEST(S)
> FAIL: pkt_testdriver
> 
> this is not specific to OpenSSL (1.1.1*) or mbedTLS, but seems to
> be "a Linux thing", so I assume it's something related to sockaddr
> (as this patch fixes the switch/case to actually look at the IPv4 addr)

Yeah. macOS has:

struct sockaddr_in {
	__uint8_t       sin_len;
	sa_family_t     sin_family;
	in_port_t       sin_port;
	struct  in_addr sin_addr;
	char            sin_zero[8];
};

with sa_family_t also uint8_t

and Linux has stupidly complex definition that boils down to:

struct sockaddr_in
   {
     uint16_t sin_family;
     in_port_t sin_port;
     struct in_addr sin_addr
     char sin_zero[8];
   };

So Linux basically has a 16 bit uint16 instead of two uint8_t. Because 
s390x is big endian, this happens to be same as on all BSDs with first 
byte being 0 and second byte being the family.

I will send a fix that fixes the fix *grumbels*

Arne



