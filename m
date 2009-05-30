Message-ID: <4A210CB1.6050802@...41...>
Date: Sat, 30 May 2009 04:38:41 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <f9615cc80905271048v646f546fod19ecec32c2a172a@...278...>
	<20090528055401.GB24851@...1066...>
In-Reply-To: <20090528055401.GB24851@...1066...>
Subject: Re: [Openvpn-devel] Unable to use -OFB or -CFB ciphers in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Victor Wagner wrote:
> On 2009.05.27 at 10:48:30 -0700, Frank Yellin wrote:
> 
>>    I posted the following onto the OpenVPN forum, but it was suggested
>>    that I would be better off mailing directly to this list.
>>    =========================
>>    I seem to have found a bug in 2.1_rc16 that is also apparent in earlier
>>    versions. Although OpenVPN claims to support -CFB and -OFB cipher
>>    modes, using them seems to cause OpenVPN to crash consistently.
>>
>>    For example, when I run the simple TLS example on the 2.1 documentation
>>    page, it works fine.  But if I add "--cipher bf-cfb" to both the client
>>    and server command lines, one or the other will crash. The error
>>    message is always "Assertion failed at crypto.c:162". The crasher is
>>    always the first one to try and send an encrypted message.
> 
> I've reported this problem more than a year ago, but nothing changed.
> I really don't understand why openvpn prefers CBC modes. There is
> nothing wrong with CFB and OFB neither from securith nor from
> performance point of view.
> 
> But it is not only problem with non-CBC ciphers. If you try to use
> preshared keys, you'll find out that they are explicitely disabled
> unless --test-crypto option is given, even if your compile with 
> -DALLOW_NON_CBC_CIPHERS.
> 
> Also, I've encountered some problems with UDP transport and stream
> ciphers which I haven't find time to debug yet.
> 

The OFB and CFB cipher modes in OpenVPN have not been well-tested and 
should be considered experimental at this point.

They are not compiled by default mostly to prevent someone from 
accidentally using them.

James

