References: <CAALvpZTo6VYxcLXtXXyMsUU-n3JRSOJ-62fny7Zfi28WSDYXmA@...278...>
 <b63128cc-14cf-b1a4-684d-4c3fcb291f04@...2181...>
 <20210328085248.GB976@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <de2361f5-e30d-3e05-8a2e-52c8e8018151@...2181...>
Date: Sun, 28 Mar 2021 11:55:20 +0200
MIME-Version: 1.0
In-Reply-To: <20210328085248.GB976@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Stop using deprecated getpass()
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
To: Gert Doering <gert@...1296...>
Cc: =?UTF-8?Q?T=c3=b5ivo_Leedj=c3=a4rv?= <toivol@...277...>, openvpn-devel@lists.sourceforge.net

Hi,

On 28/03/2021 10:52, Gert Doering wrote:
> [..]
>>> +    {
>>> +        (void) tcsetattr(fileno(fp), TCSAFLUSH, &tty_save);
>>
>> We should not need to cast to void - I don't think we have warnings set
>> for non-checked return values.
> 
> Actually we should catch errors here and log them.  If tcsetattr() fails, 
> the tty will be in a messed-up state - so we want to know that it happened,
> and possibly also the "why".

True. I totally agree here.

Cheers,

-- 
Antonio Quartulli

