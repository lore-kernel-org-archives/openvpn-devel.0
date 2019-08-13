References: <20190812134513.20758-1-arne@...1227...>
 <a1b2525b-fb00-4d8d-d877-797305c6ec2f@...2181...>
 <038d3040-5133-9841-ca28-d433ca228f0c@...2080...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <a214be99-8c20-56e0-7dcd-3a8425129dfb@...2181...>
Date: Tue, 13 Aug 2019 23:31:09 +0200
MIME-Version: 1.0
In-Reply-To: <038d3040-5133-9841-ca28-d433ca228f0c@...2080...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/2] Fix check if iface name is set
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
To: David Sommerseth <openvpn@...2080...>, Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 13/08/2019 23:26, David Sommerseth wrote:
> wouldn't it be better to
> do 'if (rgi6->iface[0])' instead?  Since the buffer should be NULL terminated
> and has to be NULL terminted for strlen() to function anyhow.  But the
> compiled code would be a bit more efficient (even though, this isn't
> necessarily a performance critical code section).

In my opinion strlen() is more readable for the casual developer
checking this code. Behind iface[0] we may hide other ambiguous
assumptions (even though this is not the case here, but we won't
remember in some months from now).

Cheers,

-- 
Antonio Quartulli

