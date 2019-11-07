References: <20191009143422.9419-3-a@...2181...>
 <201911062041.xA6KfP8R010468@...2054...>
 <CAGyAFMWBd2GzuZdBfTfGwROPw-hEzqSMUCUY3vrWENeqd1A46w@...278...>
 <20191107122743.GQ40538@...1296...>
 <CAGyAFMU5VAWDPuR7V3dTMKBsDbn2vgH61sgn6O9dtZNi-OTebQ@...278...>
 <99D61A626FDA8A4B90A270669121BE10BDA46060@...2294...>
 <99D61A626FDA8A4B90A270669121BE10BDA461DD@...2294...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <b508ea7f-ccba-2159-a0df-e850437d5701@...2181...>
Date: Thu, 7 Nov 2019 14:38:30 +0100
MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10BDA461DD@...2294...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH applied] Re: VLAN: add basic VLAN
 tagging support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Simon Rozman <simon@...2293...>, 'Lev Stipakov' <lstipakov@...277...>, 'Gert Doering' <gert@...1296...>
Cc: 'openvpn-devel' <openvpn-devel@lists.sourceforge.net>

Hi,

On 07/11/2019 14:36, Simon Rozman wrote:
> I revoke this “master.c” idea. It makes incremental compiling ridiculously slow. It might work for production builds, but definitely not for development.

It also breaks scoping of variables/function. So, I am glad you found
your own reason to reject that :-)


-- 
Antonio Quartulli

