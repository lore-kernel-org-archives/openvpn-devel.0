Message-ID: <70cfc6aa-e0a4-4c89-aedd-f4f790e3679c@...2181...>
Date: Mon, 20 Nov 2023 10:37:47 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <69296454-829c-4f6b-a528-a741e8ef96d2@...2702...>
 <c4b46bc4-b953-e2a3-91c0-1a015773306f@...1227...>
 <b3885e07-bc56-40da-925b-5ef0c2d7faaa@...2702...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <b3885e07-bc56-40da-925b-5ef0c2d7faaa@...2702...>
Subject: Re: [Openvpn-devel] OpenVPN3 thread safety
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Savely Krasovsky <savely@...2753...>, Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 20/11/2023 10:11, Savely Krasovsky wrote:
> Thanks for the reply!
> 
> After few days I have found a major bug: a close and free client before stop() successfully executes. After fixing this I didn't get any segfaults anymore. Program survives very extensive tests. But after your reply I am in question again... Sure, openvpn3 has single thread after Connect(), but Go still could call Stop() or any other method from another thread. And still I didn't get any issues at the moment. Should I rewrite it anyway?
> 


Calling from different threads is not an issue.
Invoking multiple methods at the same time is.

If you call openvpn3 code from multiple threads, it may be better for 
you to implement your own locking system "outside" of the library which 
makes sure no more than one caller is running openvpn3 code at a given 
moment.

Cheers,

> Пн, 20.11.2023 в 9:55 Arne Schwabe писал(а):
>> Am 12.11.2023 um 14:16 schrieb Savely Krasovsky:
>>> Hello!
>>>
>>> I am trying to use OpenVPN3 with Golang SWIG binding. It works pretty nice, but I have random segmentation faults without obvious reason. My current guess is that Golang calls OpenVPN3 from various threads and library is not ready for that sometime. Am I right? Documentation doesn't say a lot about threading.
>>>
>>> If this is a case, I have two possible solutions:
>>>    1. Use OPENVPN_ENABLE_BIGMUTEX build flag (I am not sure I need that).
>>>    2. Move all calls to OpenVPN3 into single goroutine and use runtime.LockOSThread().
>>>
>>> Could you please clarify, should I get segfaults in that case or not and the problems is unrelated.
>>
>>
>> Yes. The client is singlethreaded and expects to be called only from a
>> single thread. You can have multiple clients in multiple threads but all
>> our own software uses just a single thread for the client itself.
>>
>>
>> Arne
> 

-- 
Antonio Quartulli

