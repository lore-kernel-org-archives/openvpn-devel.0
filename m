Message-ID: <d0cd57b8-82aa-31cf-1db5-c328ab775748@...2181...>
Date: Tue, 8 Mar 2022 15:23:17 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20220224165557.22060-1-kprovost@...2661...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220224165557.22060-1-kprovost@...2661...>
Subject: Re: [Openvpn-devel] [PATCH DCO]: FreeBSD DCO support
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
To: Kristof Provost <kprovost@...2661...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 24/02/2022 17:55, Kristof Provost via Openvpn-devel wrote:
> I've had to add a lot of '|| defined(TARGET_FREEBSD)', and I think the
> code could be a bit cleaner if we'd make these calls conditional only on
> defined(ENABLE_DCO), and instead expect every DCO implementation to
> provide them, if only as stubs. I've not done that here.

Can you name what new internal APIs would you want to add?
I am also in favor of less ifdefs and have APIs that can be defined as 
stub or not based on the platform.


A comment for your kernel API:
I have seen you created an API named "OVPN_SET_TIMEOUT", however I'd 
suggest to name it "OVPN_SET_PEER" (like on Linux and Windows), because 
the idea is that this call will be used to set any additional/optional 
per-peer param.

For example, we have been recently working on mssfix, which we may want 
to set on a per-peer basis (more params may come later).

The SET_PEER call will allow to set all these params (if specified).

What do you think?

Regards,

-- 
Antonio Quartulli

