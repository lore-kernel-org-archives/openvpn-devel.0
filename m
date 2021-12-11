Message-ID: <9f4c15c47f84a76f80eb6aa4792c2c105de8fa5c.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Sat, 11 Dec 2021 12:33:21 -0500
In-Reply-To: <59d7ff32-d7b3-6139-702b-a0a2895c7b4c@...68...>
References: <59d7ff32-d7b3-6139-702b-a0a2895c7b4c@...68...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Licensing questions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Matthias Andree <matthias.andree@...68...>, openvpn-devel@lists.sourceforge.net

On Sat, 2021-12-11 at 13:58 +0100, Matthias Andree wrote:
> Greetings,
> 
> I am seeking clarification on licensing, judging from OpenVPN 2.5.X
> (meaning latest 2.5).
> 
> 1. mbedTLS licensing compatibility. AFAICS, mbedTLS is currently
> under dual Apache License 2.0 and GPLv2, 
> https://tls.mbed.org/download - while OpenVPN is under GPLv2-only
> license (not the "or any later version") clause, as of 2.5.4, where
> the mbedTLS future license will be Apache License 2.0 only - this
> will be incompatible with GPLv2 but not GPLv3.
> https://www.gnu.org/licenses/license-list#apache2

Actually, this isn't a correct analysis:  the gnu.org statement above
covers the case where code is integrated into the work, not the case
where the code forms part of a system library.  GPL contains a specific
exception in section 3 for system libraries, meaning if you link a GPL
covered work with them, they don't also come under the terms of GPL. 
That's how GPL programs can get linked with proprietary C libraries,
for instance, as that was the original use case for GNU tools before
Linux came along.

However, the system exception doesn't save you where the Library itself
imposes conditions on the work it links with; then you get an
incompatibility you need an exception in the work for.  The Apache
licence doesn't do this, so linking openvpn with mbedTLS will be fine
even after it transitions to Apache-2.0.  The problematic licence was
the old openssl one because it imposed an advertising requirement on
the combined work which then becomes incompatible with GPL.

James



