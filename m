References: <5f81e5b6-7500-7754-0296-0665c85fdc3e@...277...>
 <2fb10cd6-296d-5aa7-c078-cd7b04f4fc6c@...2080...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <ffb998e2-4651-7f6a-9061-1c2dd71b4482@...277...>
Date: Fri, 4 Sep 2020 18:44:08 +0100
MIME-Version: 1.0
In-Reply-To: <2fb10cd6-296d-5aa7-c078-cd7b04f4fc6c@...2080...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] New man-section pages format
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



On 04/09/2020 14:36, David Sommerseth wrote:
> On 04/09/2020 15:21, tincanteksup wrote:
>> Hi,
>>
>> this is just something to chew-over..
>>
>> See:
>> https://github.com/OpenVPN/openvpn/blob/master/doc/man-sections/generic-options.rst
>>
>>
>> I noticed that generally the option names, eg: --auth-nocache, wrap and the
>> result is unpleasant.
>>
>> However, further down that same page --daemon progname does not wrap and looks
>> much nicer.
>>
>> I know which format I prefer, perhaps this can be changed..
> 
> Do you mean the wrapping in the HTML rendering on GitHub?  That can only be
> changed by changing the number of characters in the option.  It's not
> something we control, it's the GitHub .rst rendering.
> 
> $ echo -n "--daemon progname" | wc -c
> 17
> $ echo -n "--auth-nocache" | wc -c
> 14
> 
> IIRC, the limit is more than 16 characters, and the option gets a cell on a
> single line.
> 
> Now, if you find a setting we can tweak (even a .. notation in the .rst files)
> where we can reduce this limit to 2 character (which means all options gets
> its own line - which will be consistent all over), I'm open to consider that.
>   I haven't had time to dig into it.
> 
> But I agree, the wrapping is not nice at all.  That said, we have had more
> focus on ensuring the man/*roff rendering looks nice and reasonable more than
> the HTML rendering on GitHub - in addition files which are more easy to edit
> in a text editor.  After all, the HTML rendering was just a bonus over the .8
> rendering [1] on GitHub before the .rst conversion.
> 
> [1] <https://github.com/OpenVPN/openvpn/blob/release/2.4/doc/openvpn.8>
> 
> 

Thanks David, I'll see what, if anything, can be done to wrestle github 
into submission ;-)

> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

