References: <20180417165000.3872-1-Jason@...2390...>
 <10978590-889a-0ccc-4cb8-31c862ee565c@...1856...>
 <33fe1382-9dd6-82b4-1215-7f748e521a48@...1147...>
 <fd348cf4-8d17-24b1-cace-f238d319c550@...1227...>
 <03f8402c-a603-3405-543a-e5eaa1ebc224@...1147...>
 <1d803ca0-2f28-585c-eeca-4c64ac2d745f@...1227...>
 <d8fe4a16-fc48-f1f9-3d4d-b82a906bb322@...2080...>
 <99D61A626FDA8A4B90A270669121BE1086A96359@...2294...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <82af2541-5e7a-7ba3-5fea-e11f6a2aa52e@...1147...>
Date: Fri, 25 May 2018 15:51:22 +0200
MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE1086A96359@...2294...>
Content-Language: nl-NL
Subject: Re: [Openvpn-devel] [PATCH] Support fingerprint authentication
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Simon Rozman <simon@...2293...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 25/05/18 03:41, Simon Rozman wrote:
>>> Private and public key are still used. The patch stil uses
>>> certificates and TLS, it only replaces the check certificate of the
>>> peer's certificate against the CA with a hash check (certificate
>>> pinning if you want).
>>>
>>> So basically instead of saying that you trust all certificates signed
>>> by a CA, you only trust only those certifcates of which have hashes. A
>>> certificate pinning of an unknown CA is exactly the same. Since you
>>> cannot verify that certificate you add a one off certificate in your
>>> list of trusted certificates.
>> Correct me if I'm wrong, but this approach allows for self-signed
> certificates
>> too, right?
> Exactly! Client and server can use whatever certificate they like or make a
> self-signed one. All they need to do is to exchange their fingerprints over
> some trustworthy channel.
>
> Simple. Like SSH.
>
>
for the record: this is not entirely the same as SSH. What happens when 
establishing an SSH connection to a new server is that you send the 
*public key* to the server, not a hash; similarly the server sends its 
public key to the client. The client needs to accept this new key, 
otherwise the connection is aborted. For public/priv authentication to 
work, the server must know the public key of the client (listed in the 
authorized_keys file) , otherwise the user is prompted for a password. 
Thus, for SSH a 'trustworthy channel' consists of the user typing 'y' 
when connecting to a new server and the server accepting a 
username+password upon first connection from a client.

To implement a similar feature in OpenVPN would require a way to send 
only the public key upon TLS initialisation, and these public keys would 
then need to be stored/listed on the server somewhere. Probably 
possible, but a different approach then to what is proposed above. I'd 
be (slightly) in favour of sending public keys instead of hashes, BTW, 
as it them more closely mimicks what SSH does.

JM2CW,

JJK


