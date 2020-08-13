References: <cc9094b8-caa6-34b6-ed7a-3ccb34560113@...1918...>
 <20200811093227.GE75094@...1296...>
From: Eric Thorpe <eric@...1918...>
Message-ID: <1de7a03b-4e55-e8c0-7ce2-95f9b011e0fc@...1918...>
Date: Thu, 13 Aug 2020 17:32:42 +1000
MIME-Version: 1.0
In-Reply-To: <20200811093227.GE75094@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] Send auth fail to client on
 reneg failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Have re-based to master and resent.

Cheers,
Eric

---
Eric Thorpe
SparkLabs Developer
https://www.sparklabs.com
https://twitter.com/sparklabs
support@...1918...

On 11/08/2020 7:32 pm, Gert Doering wrote:
> Hi,
>
> On Thu, Apr 11, 2019 at 12:07:27PM +1000, Eric Thorpe wrote:
>> This patch relies on Arne's "Add send_control_channel_string_dowork
>> variant" patch.
> So.  After we left you out in the cold for over a year (apologies
> for that), we should revisit your patch set.
>
> I checked with Arne, he says "no, that functionality is not in yet,
> but still interesting" - and all the *other* auth/plugin/async/SSO
> related code we had brewing is in.
>
> So - if you're not too frustrated with us yet: can you re-send?
>
> gert

