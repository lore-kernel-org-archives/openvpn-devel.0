Message-ID: <b0a94567-184e-91c6-e186-16235e100258@...1227...>
Date: Tue, 8 Mar 2022 18:31:26 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20220224165557.22060-1-kprovost@...2661...>
 <d0cd57b8-82aa-31cf-1db5-c328ab775748@...2181...>
 <97D71D19-9B45-477B-919C-A563EC93B054@...2661...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <97D71D19-9B45-477B-919C-A563EC93B054@...2661...>
Subject: Re: [Openvpn-devel] [PATCH DCO]: FreeBSD DCO support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Kristof Provost <kprovost@...2661...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 08.03.22 um 15:45 schrieb Kristof Provost via Openvpn-devel:
> On 8 Mar 2022, at 15:23, Antonio Quartulli wrote:
>> On 24/02/2022 17:55, Kristof Provost via Openvpn-devel wrote:
>>> I've had to add a lot of '|| defined(TARGET_FREEBSD)', and I think the
>>> code could be a bit cleaner if we'd make these calls conditional only on
>>> defined(ENABLE_DCO), and instead expect every DCO implementation to
>>> provide them, if only as stubs. I've not done that here.
>>
>> Can you name what new internal APIs would you want to add?
>> I am also in favor of less ifdefs and have APIs that can be defined as stub or not based on the platform.
>>
> We’ve got a significant number of cases where we call DCO functions for Linux & FreeBSD but not for Windows.
> One example is the call to dco_event_state() in multi_tcp_wait() and io_wait_doword().
> If windows provided an implementation for that, even if it did no work, we could replace ‘#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)’ with an ‘#ifdef ENABLE_DCO’. If we provided a stub implementation for the DCO functions even for non-DCO builds we wouldn’t need any ‘#ifdef’ at all.

A lot of these calls might be because of the missing multi support on 
Windows. Maybe we can also have a DCO_MULTI instead. BUt stub functions 
might also work.

Arne

