Message-ID: <3288fcba-bceb-1700-b080-1e6d24c80da3@...1227...>
Date: Thu, 6 Jul 2023 12:45:18 +0200
MIME-Version: 1.0
References: <20230704130902.105585-1-frank@...2641...>
 <20230706100407.231175-1-frank@...2641...>
 <ZKaVskYf9XFozQsf@...2685...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <ZKaVskYf9XFozQsf@...2685...>
Subject: Re: [Openvpn-devel] [PATCH] GHA: Add work-around for rst2*.py not
 being directly executable on Windows
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
To: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net

Am 06.07.23 um 12:21 schrieb Frank Lichtenheld:
> On Thu, Jul 06, 2023 at 12:04:07PM +0200, Frank Lichtenheld wrote:
>> We write a small .bat file wrapper and then force CMake
>> to use that.
>>
>> Note that we need to specify the path with / instead of \
>> as path separator because otherwise run-cmake action will
>> mangle it.
>>
>> Change-Id: I05d3f7f3f7f7418d1977e523c6dcfb6fa5feb604
>> Signed-off-by: Frank Lichtenheld <frank@...2641...>
>> ---
>>   .github/workflows/build.yaml | 21 ++++++++++++++++++++-
>>   1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> This is an alternate patch to "CMake: Support doc builds on
>> Windows machines that do not have .py file association" since
>> there was some doubt on IRC whether we want to have the complexity
>> inside of CMake or should delegate that to the caller.
>>
>> Let me know your opinions.
> 
> Personally I prefer the original solution inside CMake.
> It just solves the problem in a wide range of potential setups
> without additional effort required by the caller. I think the
> slightly increased complexity can be accepted for that.

I concur for the same reasons. This is also harder for people to 
replicate on their own setups. They will have to manually write scripts 
instead of jsut having cmake dealing with the problem.

Arne


