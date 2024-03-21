Message-ID: <9dd314e4-4dd9-49fa-b325-de0e8f166747@...1227...>
Date: Thu, 21 Mar 2024 12:38:45 -0400
MIME-Version: 1.0
References: <20230830130502.1029-1-sandro.trianni@...277...>
 <20240315162011.1661139-1-frank@...2641...>
 <ZfR54tXN8gxWr4A0@...2685...>
 <ZfsXglouFPyXApqf@...1296...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <ZfsXglouFPyXApqf@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] Implement server_poll_timeout for
 socks
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
To: Gert Doering <gert@...1296...>, Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Am 20.03.24 um 13:06 schrieb Gert Doering:
> Hi,
> 
> On Fri, Mar 15, 2024 at 05:40:02PM +0100, Frank Lichtenheld wrote:
>> Code looks good and I tested build and default t_client tests.
>> However, not sure how exactly to verify that it actually works.
>> The SOCKS proxy I have doesn't exhibit any problems even with
>> --connect-timeout 1.
>>
>> Any ideas for testing welcome.
> 
> As far as I understand this fix, it's replacing the 5s hard coded timeout
> for "handshake with the SOCKS proxy" with --connect-timeout.
> 
> So to exhibit any change in behaviour, you need a slow SOCKs proxy...
> 
> I have a few ideas how to test this, like
> 
>   - --socks-proxy <non-answering-ip>:10080
>     (should fail after 5 seconds without the patch, after --connect-timeout
>     with the patch)
> 
>   - hack "something that can speak SOCKS" (like, ssh) to be really slow
>     in answering - like, "add a sleep(15) in the socks handshake path",
>     and point OpenVPN to that.  Without the patch, this should fail, with
>     the patch, it should succeeds.
> 
>     (Note: 'ssh -D nnnn' will do SOCKS, but not UDP -> TCP server needed)
> 
> I have no time just now to go hacking on this, so just putting out the
> ideas...
> 
> For our regular testbed, testing all these timeouts is complicated
> (and even if you succeed, it's sllloowww if you want reproduceable
> results, so not "milliseconds timers").
> 

Or use something like dummynet. At least on macOS it used to be easy to 
simulate a long delay with that and pfctl.

Arne


