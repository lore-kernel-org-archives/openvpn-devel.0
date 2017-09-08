From: fragmentux <fragmentux@...277...>
References: <20170906235202.26551-1-davids@...515...>
 <45ee0784-77cf-bba1-85cf-f7c6265b25f5@...277...>
 <41cf1b9e-bb4b-a2f1-3c3a-cde43c8e0eb4@...2080...>
 <84bc7ec5-886e-7ae6-87a7-0385d0506376@...277...>
 <8c9c7f22-30a6-a192-f56d-961605a6d1c2@...2080...>
 <8aaacc62-7c5f-14d0-e1a4-a38b89c90625@...277...>
 <f5e56e77-e810-78d0-47b0-474f660f78b5@...277...>
 <dbb9942d9beb584473690320e9603933@...2277...>
 <61364cfa-6ccf-e894-4c88-674f8b9afdb2@...277...>
Message-ID: <7ef275e4-8ce4-dc47-d30e-6694c0efd8cf@...277...>
Date: Fri, 8 Sep 2017 03:04:03 +0100
MIME-Version: 1.0
In-Reply-To: <61364cfa-6ccf-e894-4c88-674f8b9afdb2@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net



On 08/09/17 02:45, fragmentux wrote:
> Hi,
> 
> On 08/09/17 02:30, Steven Haigh wrote:
>> On 2017-09-08 10:41, fragmentux wrote:
>>> WRT systemd and 3rd party 'servers'
>>>
>>> I am curious to know of any other "Server service" who decide ..
>>> to *rely* on ..
>>> a *forced* 'systemd (almost) unconditional restart by default'
>>
>> As a basic list:
>>
>> /usr/lib/systemd/system $ grep -r Restart *.service
> 
> This is the wrong place to grep ..
> 

Oops .. maybe not "the wrong place" ..
but I stand by my objection.

regards,

