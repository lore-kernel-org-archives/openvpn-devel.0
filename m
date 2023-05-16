Message-ID: <56ae8f6d-ca28-7c36-11eb-1b39ac5d16f1@...1227...>
Date: Tue, 16 May 2023 13:47:49 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20230426094931.1168078-1-arne@...1227...>
 <87zg65mrom.fsf@...2733...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <87zg65mrom.fsf@...2733...>
Subject: Re: [Openvpn-devel] [PATCH v3] Add Apache2 linking with for new
 commits
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
To: openvpn-devel@lists.sourceforge.net

Am 15.05.23 um 19:26 schrieb Jeremie Courreges-Anglas:
> On Wed, Apr 26 2023, Arne Schwabe <arne@...1227...> wrote:
>> After first round of mailing people with more than 10 commits we have
>> almost all committers have agreed. This put this license in the realm
>> of having a realistic change to work. Had any of these contributers
>> disagreed, rewriting all their code might have been not feasible.
>>
>> The rationale of adding this exception now is to avoid having to
>> have a second round of agreement for new contributers and ensure
>> that all new code will include the exemption.
> 
> The proposal here (already committed) merely adds an exception for
> linking with Apache 2 libraries.  As discussed privately with Arne, the
> proposal that I have received was to *replace* the OpenSSL linking
> exception with the Apache 2 linking exception.  The rationale being that
> OpenSSL 3 has moved to Apache 2, and that OpenVPN plans to drop support
> for OpenSSL 1.X at some point.
> 
> The LibreSSL project has not moved to Apache 2 and doesn't plan to do
> so.  OpenVPN currently builds and runs fine using LibreSSL, without any
> patch.  I don't know about the state of OpenSSL 3 APIs in LibreSSL, but
> I suggest not to tie together licensing matters and technical matters.
> 
> I think the existing OpenSSL linking exception should be kept as is.
> For the (admittedly few and uncomplicated) changes I have contributed to
> the OpenVPN code base, I would agree with a licensing change that
> doesn't remove this exception.

The reason we worded it to replace the original exception is that after 
we drop OpenSSL 1.0.2 and 1.1.1 support there would be no perceived 
reason to keep the original exception as OpenSSL will not back to that 
license and no other library will pick up that weird license. As long as 
we support OpenSSL 1.0.2 and 1.1.1 we have to keep that license 
exception anyway (which will be probably at least a few years to support 
RHEL8 (EOL 2029)). When we wrote those mails we did not consider LibreSSL.

Until this time, we intent to keep both exceptions anyway. Both 
exceptions are written in a way that they can be dropped at any time by 
any fork.

Arne


