Message-ID: <54212cc9-297e-737c-1ae0-0aa5af9d3bfd@...2181...>
Date: Wed, 16 Nov 2022 13:35:40 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20221115122940.1947284-1-arne@...1227...>
 <7e99c14a-0d3d-b539-f173-a00d79e52811@...2181...>
 <c74c85f1-dda0-c1e2-3a09-700241b9bd0b@...1227...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <c74c85f1-dda0-c1e2-3a09-700241b9bd0b@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Fix logic error in checking early
 negotiation support check
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 16/11/2022 01:54, Arne Schwabe wrote:
> Without the == it is enough if any of the bits EARLY_NEG_START is set 
> (0xf00000), we want them all to be set. If EARLY_NEG_START were a 
> flag/single bit, you would be right.

Ouch, I indeed assumed it was 1 bit only..

Cheers,


-- 
Antonio Quartulli

