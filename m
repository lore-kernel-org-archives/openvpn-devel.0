References: <20191110133525.6069-1-a@...2181...>
 <20191110133525.6069-3-a@...2181...>
 <CAKuzo_ha8xxM+bw=Lrq01dnCNhNDqzS1EQGaptjUrdDq5pqcLg@...278...>
 <20191110170338.GP40538@...1296...>
 <CAKuzo_h+qTFQvUeiCM1TewW1b1XC7OvOESbEo+CtJWmMAUgvqA@...278...>
 <20191111072328.GR40538@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <5e9d97c1-0500-fe53-c20e-7db8883892d6@...2181...>
Date: Mon, 11 Nov 2019 09:05:00 +0100
MIME-Version: 1.0
In-Reply-To: <20191111072328.GR40538@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 3/3] travis: compile with -Werror on
 Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 11/11/2019 08:23, Gert Doering wrote:
>> But the patch does affect cross-compilation for Windows on linux.
> 
> That seems to have been an oversight in how to feed Travis what we want - 
> I saw an update yesterday evening.
> 
>> Unless restricted to a very small cross-section (say gcc x.y + linux) this
>> is going to cause a lot of grief. Note that every check run by configure
>> that succeeds with warnings will become mysterious error at build time.
>> There may be other unexpected failures too. -Werror is never fit for
>> production in my view. There is a reason why warnings are warnings.
> 
> "gcc $current + linux" was the plan, and only do it in Travis, not do
> it in configure for general consumption.
> 

Right - this was my mistake while creating this patch.
A fix has been sent to the ml yesterday night. That should work as expected.

However, note that Travis won't be 100% happy because some compilers
don't have the -Wno-stringop-truncation we recently added and
configure.ac is failing to detect that....


Cheers,


-- 
Antonio Quartulli

