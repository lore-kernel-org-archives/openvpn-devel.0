From: Michal Soltys <soltys@...2503...>
References: <20190409143438.25348-1-soltys@...2503...>
 <20190409143438.25348-2-soltys@...2503...>
 <e6c17503-b1b4-7bba-e03e-3a8c8b6565e6@...1227...>
 <299950cf-ab6b-527c-ae95-d035457077d2@...2503...>
 <18b5b8e7-c5d3-e684-7241-1a563c119f08@...2503...>
Message-ID: <ea47e639-935a-a5ce-b14e-e3be77a164ea@...2503...>
Date: Thu, 13 Jun 2019 10:49:30 +0200
MIME-Version: 1.0
In-Reply-To: <18b5b8e7-c5d3-e684-7241-1a563c119f08@...2503...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/1] man: correct the description of
 --capath and --crl-verify regarding CRLs
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 19/04/10 15:51, Michal Soltys wrote:
> On 4/10/19 3:45 PM, Michal Soltys wrote:
>> On 4/10/19 10:24 AM, Arne Schwabe wrote:
>>> Am 09.04.19 um 16:34 schrieb Michal Soltys:
>>>> The man page states that when using --capath, the user is required to
>>>> provide CRLs for CAs. This is not true and providing CRLs is optional -
>>>> both in case of --capath as well as --crl-verify options. When relevant
>>>> CRL is not found OpenVPN simply logs the warning in the logs while
>>>> allowing the connection, e.g.:
>>>>
>>>
>>> On my server the connection used to fail without CRLs. I just retested
>>> this and with OpenSSL 1.1.1 there is not even a warning, so I am really
>>> confused now.
>>>
>>> Arne
>>
>> Hmm, I do have warnings (with 1.1.1 and 1.1.0), at least at --verb 3:
>>
> 
> For the record, --verb 3 or stronger is required for those warnings to 
> be logged. 2 will only record verify success, 1 won't log any of those.
> 


Anyway, it's beeen a bit since that thread - any chance to update the 
docs about this ? I can redo/rebase the patch as necessary.

