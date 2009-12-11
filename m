Message-ID: <4B229244.60308@...1114...>
Date: Fri, 11 Dec 2009 19:41:08 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <19316.65.118.50.246.1260553900.squirrel@...1166...>
In-Reply-To: <19316.65.118.50.246.1260553900.squirrel@...1166...>
Subject: Re: [Openvpn-devel] Patch for plugin/auth-pam.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Daniel Johnson <Progman2000@...1085...>
Cc: openvpn-devel@lists.sourceforge.net

On 11/12/09 18:51, Daniel Johnson wrote:
> Daniel Johnson wrote on 2008-12-12:
>> When I began testing OpenVPN v2.1_rc9 I was having trouble
>> authenticating to the MS Active Directory through auth-pam and Samba.
>> I used the following line in my configs (without the linebreak of
>> course):
> 
>> plugin /opt/openvpn/openvpn-auth-pam.so
>>                 "openvpn login OURDOMAIN+USERNAME password PASSWORD"
> 
>> Finally I turned on more verbose logging and found that the plugin
>> did not recognize "USERNAME" as something to replace, because it
>> expected the string to be surrounded by whitespace.  I wrote the
>> following patch to correct this.  I hope you find it useful,
> 
>> http://thor.chguernsey.com/temp/auth-pam.patch  (2kb)
>> http://thor.chguernsey.com/temp/auth-pam.patch.sig
>> MD5: 6560cbdfe24b3469dcb551d8963efdfa *auth-pam.patch
> 
>> Daniel Johnson
>> Progman2000@...1085...
> 
> I've seen no replies to this, and the patch did not make it into
> v2.1.0.  The patch cleanly applies to v2.1.0, is there any interest
> in merging this functionality?
> 

I just decided to do a quick review, I don't believe this has made it
into openvpn-2.1.0.  But from what I see, I have one concern in regards
to a potential memory leak.

The pam_server() function receives a "message" which puts the
information into a "static" memory area which is using struct user_pass.
 This is fine.  Then it calls pam_auth() with a pointer to this memory
region.

The pam_auth() function calls my_conv(), and if this function gets a
match on USERNAME or PASSWORD value in the block around line 562, it
calls searchandreplace() which does a strdup().  This is dynamically
allocated with strdup() and saved into return_value.  But!  In line 569,
you have this line:

		  aresp[i].resp = strdup (return_value);

I presume that the aresp[] struct is freed somehow, I have not dug into
that now.  But you have here a double strdup() situation if you get a
match on USERNAME or PASSWORD.  It's almost like saying:

		char *ptr = strdup (strdup ("string"));
		free(ptr);

This code will give you a memory leak.
	
Please confirm if my assumptions are correct.  I would probably suggest
to move the strdup() on line 569 and skip using the return_value at all.
 Just use aresp[i].resp directly.


kind regards,

David Sommerseth

